<script setup>

import {dateFormat, shortcuts} from "@/tool/date.js";
import NormalPageLayout from "@/view/layout/normal-page-layout.vue";
import {xlsx} from "@/tool/excel.js";


const list = ref([])
const choosed = ref([]);
const table = ref();
const search_like = ref(true);
const timerange = ref();
const filter_value = ref();
const more_search_show = ref(false);
const search = ref({});
//  watch([变量1, 变量2], callback) 监听 currentPage 和 pageSize 的变化 immediate: true 加载就搜索
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

const handleSelectionChange = (rows, ignoreSelectable) => {
  choosed.value = []
  rows.forEach((row) => {
    choosed.value.push(row.accountId);
  })
}
const toggleSelection = (row) => {
  const index = choosed.value.findIndex(item => item === row.accountId);
  table.value.toggleRowSelection(row,index === -1)
}
function query(){
    list.value = [];
    pagination.value.total = 0;
}
onBeforeMount(() => {
  // 预加载或数据检查。
})
</script>

<template>
  <normal-page-layout>
    <template  #header>
      <div style="display: flex;align-items: center;justify-content: space-between;">
        <div>
          <el-input clearable style="width: 200px" placeholder="搜索登录账号" size="small" prefix-icon="Search" v-model="search.loginName">
            <template #append>
              <el-switch v-model="search.loginNameLike" inline-prompt size="small"
                         style="--el-switch-on-color: #13ce66; --el-switch-off-color: #ff4949"
                         active-text="相似" inactive-text="一致"/>
              <span style="padding: 0 5px;cursor: pointer;" @click="query()">搜索</span>
            </template>
          </el-input>
          <el-input clearable style="width: 200px;padding-left:5px;" placeholder="搜索昵称"
                    size="small" prefix-icon="Search" v-model="search.nickName">
            <template #append>
              <el-switch v-model="search.nickNameLike" inline-prompt  size="small"
                         style="--el-switch-on-color: #13ce66; --el-switch-off-color: #ff4949"
                         active-text="相似" inactive-text="一致"/>
              <span style="padding: 0 5px;cursor: pointer;" @click="query()">搜索</span>
            </template>
          </el-input>
        </div>
        <div class="flex">
          <el-button v-if="!more_search_show" size="small" @click="query()">搜索</el-button>
          <!--      :hover{color:#303133}-->
          <!--          <div class="flex-center" style="cursor: pointer;" @click="action_new_account=true;">
                      <el-icon style="margin: 0 4px;cursor: pointer;color:#909399;">
                        <Plus/>
                      </el-icon>
                      创建用户
                    </div>-->
          <div v-if="!more_search_show" class="flex-center" style="cursor: pointer;" @click="more_search_show=!more_search_show">
            <el-icon style="margin: 0 4px;cursor: pointer;color:#909399;transition:.2s;">
              <Filter/>
            </el-icon>
            更多筛选
          </div>
        </div>
      </div>
      <!--        其它条件-->
      <div v-show="more_search_show" style="padding-top: 5px">
        <el-row>
          <div style="margin-right: 5px;">注册时间:
            <el-date-picker size="small" type="datetimerange" value-format="x" format="YYYY/MM/DD HH:mm:ss"
                            v-model="search.createAt" :shortcuts="shortcuts" />
          </div>

          <div>最后操作时间:
            <el-date-picker size="small" type="datetimerange" value-format="x" format="YYYY/MM/DD HH:mm:ss"
                            v-model="search.requestAt" :shortcuts="shortcuts" />
          </div>
        </el-row>

        <div class="flex-center" style="padding-top:5px;">
          <el-button size="small" @click="query()">搜索</el-button>
          <el-button size="small" @click="search={}">清空搜索条件</el-button>
          <div v-if="more_search_show" class="flex-center" style="cursor: pointer;" @click="more_search_show=!more_search_show">
            <el-icon style="margin: 0 4px;cursor: pointer;color:#909399;transition:.2s;">
              <Filter/>
            </el-icon>
            {{more_search_show?'隐藏':'更多'}}筛选
          </div>
        </div>

      </div>
      <!--      操作      -->
      <div v-if="choosed.length > 0" style="padding-top: 5px;">
        <el-button size="small">启用</el-button>
        <el-button size="small">禁用</el-button>
        <el-button size="small">备注</el-button>
      </div>
    </template>
    <template #main>
      <el-auto-resizer v-slot="{ height, width }">
        <el-table ref="table" :data="list" :row-key="row => row.accountId"
                  @row-click="toggleSelection" @selection-change="handleSelectionChange"
                  highlight-current-row stripe :max-height="height" style="width: 100%"
        >

          <!--  v-loading="loading" :expand-row-keys="expandedRows" @row-click="handleRowClick"        -->
          <!--    show-overflow-tooltip-->
          <el-table-column type="selection" width="20"/>
          <el-table-column fixed="left" prop="accountId" label="UID" width="80" show-overflow-tooltip/>
          <el-table-column prop="loginType" label="登录方式" width="80"/>
          <el-table-column prop="loginName" label="登录账号" width="120" show-overflow-tooltip/>
          <el-table-column prop="nickName" label="昵称" width="80" show-overflow-tooltip/>
          <el-table-column prop="kycName" label="KYC名字" width="180" show-overflow-tooltip/>
          <el-table-column prop="exp" label="经验值" width="80" show-overflow-tooltip/>
          <el-table-column prop="vipLevel" label="VIP等级" width="80" show-overflow-tooltip>
            <template #default="scope">
              <div v-if="scope.row.vipLevel!=null && scope.row.vipLevel!==0">
                {{scope.row.vipLevel}}
              </div>
              <div v-else>暂无</div>
            </template>
          </el-table-column>

          <el-table-column prop="recharge" label="充值金额" width="80" show-overflow-tooltip/>
          <el-table-column prop="rechargeTimes" label="充值次数" width="80" show-overflow-tooltip/>
          <el-table-column prop="withdrawTimes" label="提现次数" width="80" show-overflow-tooltip/>
          <el-table-column  label="净充值" width="80" show-overflow-tooltip>
            <template #default="scope">{{ scope.row.recharge-scope.row.withdraw }}</template>
          </el-table-column>

          <el-table-column prop="bonus" label="福利" width="80" show-overflow-tooltip/>
          <el-table-column prop="rebate" label="推广返佣" width="80" show-overflow-tooltip/>
          <el-table-column prop="gameLose" label="游戏亏损" width="80" show-overflow-tooltip/>

          <el-table-column prop="balance" label="总余额" width="80" show-overflow-tooltip>
            <template #default="scope">{{ scope.row.balance+scope.row.balancePending }}</template>
          </el-table-column>

          <el-table-column prop="relative" label="上级" width="80" show-overflow-tooltip>
            <template #default="scope">{{scope.row.relative}}</template>
          </el-table-column>
          <el-table-column prop="invite" label="邀请数" width="80" show-overflow-tooltip/>
          <el-table-column prop="teamMember" label="裂变数" width="80" show-overflow-tooltip/>


          <el-table-column prop="requestAt" label="在线时间" width="100" show-overflow-tooltip  :formatter="dateFormat"/>
          <el-table-column prop="createAt" label="注册时间" width="100" show-overflow-tooltip :formatter="dateFormat"/>

          <!--              <el-table-column prop="product" label="应用" width="80" show-overflow-tooltip/>-->

          <el-table-column prop="remark" label="备注" width="80" show-overflow-tooltip>
            <template #default="scope"><div class="ck-content truncate"
                                            style="height:20px;white-space: nowrap;"
                                            v-html="scope.row.remark"></div></template>
          </el-table-column>

          <el-table-column  fixed="right" label="" width="40">
            <template #default="scope">
                <span style="margin:0 5px;color: var(--main);cursor: pointer;"
                      @click.native.stop="new_tab('会员详情 ('+scope.row.accountId+')','/account_board?accountId='+scope.row.accountId);">
                  详情
                </span>
            </template>
          </el-table-column>
        </el-table>
      </el-auto-resizer>
    </template>
    <template v-slot:footer>
      <div style="display: flex;align-items: center;justify-content: space-between;">
        <div></div>
        <el-pagination
            v-model:current-page="pagination.page"
            v-model:page-size="pagination.size"
            :total="pagination.total"
            :page-sizes="[50,100,500,1000]"
            size="small"
            layout="total, sizes, prev, pager, next"
            @size-change="(num)=>{pagination.size=num}"
            @current-change="(num)=>{pagination.page=num}"
        />
        <div @click="xlsx(list,'test')">导出Excel</div>
      </div>
      <!--            :disabled="disabled"
            :background="background"-->
    </template>
  </normal-page-layout>
</template>

<style scoped lang="scss">
:deep(.el-input-group__append){
  padding:0 5px!important;
}

:deep(.el-table){user-select: text;background-color: transparent!important;}
:deep(.el-table--border .el-table__cell){
  border-bottom-color: #ccc!important;
  border-right-color: #ccc!important;
}
:deep(.el-table thead .cell){ padding: 0 0 !important;}
:deep(.el-table tbody .cell ,.el-table tbody .el-table__cell ){
  line-height: 18px !important;
  /*padding: 0 0 !important;*/
  padding: 1px!important;
  font-size: 13px !important;
  word-break: unset !important;
  white-space: nowrap!important;  /* 防止文本换行 */
  overflow: hidden!important;     /* 超出部分隐藏 */
  text-overflow: ellipsis!important; /* 使用省略号表示溢出的文本 */
}

</style>