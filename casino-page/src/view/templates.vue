<template>
  <div class="flex">
    <el-icon size="32"><QuestionFilled /></el-icon>
    <el-icon size="32"><Edit /></el-icon>
    <el-icon size="32"><Operation /></el-icon>
    <el-icon size="32"><Guide /></el-icon>
    <el-button type="primary" @click="pop_by_container('/pop/container/close_bottom','/example/new-version')">新页面</el-button>
  </div>
  <div style="height:calc(100% - 40px);overflow: auto;">
      <ListCard>
      <div class="card" v-for="item in list" :key="item.example">
        <img :src="item.example"/>
        <!-- style="white-space: pre-wrap;"     -->
        <div   class="truncate" >
          123xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        </div>
        <div style="text-align: center">
          <el-button type="primary" round size="small">删除</el-button>
          <el-button type="primary" round size="small">修改</el-button>
        </div>
      </div>
      </ListCard>
</div>

</template>

<script setup>
// 解析 URL 并存储邀请码
import {pop_by_container} from "@/init/pop.js";
import ListCard from "@/view/example/list-card.vue";

const urlParams = new URLSearchParams(window.location.search);
const key = urlParams.get("key");
if (key) {
  console.log("页面key:", key);
}
const list = ref([
    {example:'https://image.meiye.art/pic_1750165986844?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
    {example:'https://image.meiye.art/pic_1750164347033?imageMogr2/thumbnail/640x/interlace/1'},
])

</script>

<style scoped lang="scss">
/*
✅ 当卡片数量少（不足以占满一行）时 → 卡片宽度固定，不被拉伸
✅ 当卡片数量多（可以排满或超出一行）时 → 自动均分一行空间，形成宫格布局*/
/*.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 10px;
}*/

.card {
  border: 1px solid #cbe6dd;
  img{width: 100%;aspect-ratio: 1 /1;}
}
</style>
