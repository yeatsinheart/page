<script setup>
const params = defineProps({
  /*优先固定格子*/
  columns:{type: Number},// 一行固定几格
  /*非固定格子则按照最小卡片宽度优先*/
  gap:{type: String,default:()=>".1rem"},// 单位px 或者rem eg:200px 6rem
  minCardWidth:{type: String,default:()=>"3rem"},// 最小卡片宽度 单位px 或者rem eg:200px 6rem
})
function getNumber(value){
  const remInPx = parseFloat(getComputedStyle(document.documentElement).fontSize);//1rem=xxx
  if(value.indexOf("rem")>0){
    return remInPx*parseFloat(value.replace("rem",""));
  }
  if(value.indexOf("px")>0){
    return parseFloat(value.replace("px",""))
  }
}
const updateColumns = () => {
  const container = document.querySelector('.col');
  if (!container) return;
  const width = container.offsetWidth;// px 宽度


  let gapPx = getNumber(params.gap)??7.3;
  let cols = 1;
  if(params.columns) {
    cols = params.columns;
  }else {
    if(params.minCardWidth) {
      let cardWidth = getNumber(params.minCardWidth)??100;
      cols=Math.max(1, Math.floor(width/(cardWidth+gapPx)))
    }else {
      if (width > 1000) cols = 6;
      else if (width > 800) cols = 5;
      else if (width > 600) cols = 4;
      else if (width > 400) cols = 3;
      else cols = 2;
    }
  }
  container.style.setProperty('--card-columns', cols);
  container.style.setProperty('--card-gap', params.gap);
};
onMounted(()=>{
  const container = document.querySelector('.col');
  if (container) {
    const observer = new ResizeObserver(updateColumns);
    observer.observe(container);
    onUnmounted(() => {
      observer.disconnect(); // ✅ 清理所有观察者
    });
  }
  // 初始执行一次
  updateColumns();
})
</script>

<template>
  <div class="col" >
    <slot/>
  </div>
</template>

<style scoped lang="scss">
/*基于外部css文件中的

.col {
    --card-columns: 1;
--card-gap: .1rem;
width: 100%;
          gap: var(--card-gap);
display: flex;
flex-wrap: wrap;
justify-content: flex-start;
}

.col > div {
  position: relative;
  align-content: center;
  background-color: var(--bg1);
  box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  width: calc((100% - (var(--card-columns) - 1) * var(--card-gap)) / var(--card-columns));
}
*/
</style>