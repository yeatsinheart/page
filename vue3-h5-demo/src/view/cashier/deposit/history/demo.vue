<template>
  <div class="recharge-record">
    <!-- 筛选栏 -->
<!--
    <van-search v-model="searchQuery" placeholder="请输入订单号" @search="onSearch" />

    <van-tabs v-model:active="activeTab" @click="fetchRecords">
      <van-tab title="全部" />
      <van-tab title="处理中" />
      <van-tab title="成功" />
      <van-tab title="失败" />
    </van-tabs>
-->

    <!-- 充值记录列表 -->
    <van-list v-model:loading="loading" :finished="finished" :finished-text="$t('没有更多了')" @load="loadMore">
      <van-cell v-for="order in records" :key="order.id" @click="showDetail(order)">
        <template #title>
          <div class="order-info">
            <div class="flex-center">
              <img v-if="order.paymentImg1x1!=null" :src="order.paymentImg1x1" style="width:.44rem;height:.44rem">
              <span style="padding-left: .2rem;">{{ order.amountOrder }}</span>
            </div>
            <span class="status" :class="order.status">{{ statusText(order.status) }}</span>
          </div>
        </template>
        <template #label>
          <div class="order-detail">
            <span>{{ order.orderId }}</span>
            <span>{{ dayjs(order.createAt).format('YYYY-MM-DD HH:mm:ss')}}</span>
          </div>
        </template>
      </van-cell>
    </van-list>

    <!-- 订单详情弹窗 -->
    <van-popup v-model:show="showPopup" round>
      <div class="popup-content">
        <h3>订单详情</h3>
        <p>订单号: {{ currentOrder?.id }}</p>
        <p>金额: {{ currentOrder?.amountOrder }} 元</p>
        <p>支付方式: {{ currentOrder?.paymentName }}</p>
        <p>状态: {{ statusText(currentOrder?.status) }}</p>
        <p>时间: {{ dayjs(currentOrder?.createAt).format('YYYY-MM-DD HH:mm:ss') }}</p>
        <van-button type="primary" block @click="showPopup = false">关闭</van-button>
      </div>
    </van-popup>
  </div>
</template>

<script setup>
import { ref } from "vue";
import {ApiRequest} from "@/api/index.js";

const searchQuery = ref("");
const activeTab = ref(0);
const loading = ref(false);
const finished = ref(true);
const records = ref([]);
const showPopup = ref(false);
const currentOrder = ref(null);

// 加载数据
const loadMore = () => {

};
import {useI18n} from "vue-i18n";
import dayjs from "dayjs";

const {t} = useI18n();

// 获取状态文本
const statusText = (status) => {
  const map = { pending: t("待提交"), toPay: t("待支付"), paid: t("已支付待处理"), success: t("成功"), failed: t("失败"), canceled: t("已撤销"), overtime: t("超时") };
  return map[status] || t("未知");
};

// 显示详情
const showDetail = (order) => {
  currentOrder.value = order;
  showPopup.value = true;
};

const pagination = ref({page: 1, size: 50, total: 0});
watch(
    () => [pagination.value.page, pagination.value.size], // 监听数组
    (newValue, oldValue) => {
      if(oldValue && newValue[1]!==oldValue[1]){
        pagination.value.page=1;return;
      }
      query();
    },
    { immediate: true }
);
function query() {
  ApiRequest._j0s9m9R2({size:pagination.value.size,page:pagination.value.page}).then(res => {
    records.value = res?.data||[];
    pagination.value.total = res?.total||0;
  })
}
</script>

<style scoped>
.recharge-record {
  padding: 10px;
}
.order-info {
  display: flex;
  justify-content: space-between;
}

.status {
  font-size: 14px;
  color: #666;
}
.status.pending {
  font-size: 14px;
  color: #888;
}
.status.toPay {
  font-size: 14px;
  color: var(--main);
}
.status.paid {
  color: orange;
}
.status.success {
  color: green;
}
.status.failed {
  color: red;
}
.order-detail {
  display: flex;
  justify-content: space-between;
  font-size: 12px;
  color: #666;
}
.popup-content {
  padding: 20px;
  text-align: center;
}
</style>
