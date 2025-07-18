<!--根据实际地址引用页面-->
<template>
  <!-- 需要监听 destroy
  最大宽度6.5rem class="flex-center"
  -->
  <!-- 遮罩层 -->
  <div style="height:100%;background: var(--mask);">
    <!--  窗体  -->
    <div  style="width: 80%;height:100%;flex-direction: column;position: absolute;right: 0;"
          @touchstart.passive="onTouchStart"
          @touchmove.passive="onTouchMove"
          @touchend="onTouchEnd"
          :style="{ transform: `translateY(${translateY}px)` }"
    >
      <div class="flex-center" style="position: absolute;right:0;width: 1rem;height: 1rem;z-index: 3000;" @click="notifyParent" >
        <i style="font-size: .45rem;" class="fa-sharp fa-regular fa-circle-xmark"></i>
      </div>
      <div ref="scrollable" style="height:100%;padding:4px;background-color:var(--page);overflow-y: auto;">
        <!-- 内部内容过高 可以滚动 @destroy="notifyParent"-->
        <component :is="props.async_component" :props="params" ></component>
      </div>
    </div>
  </div>

</template>

<script setup>
const emit = defineEmits(["destroy"]);
const notifyParent = () => {emit('destroy');};
// 外部传入参数
const data = defineProps({props:null,});

// ✅ 让 props.params 变成响应式
//const params = toRef(data.props?? {}, "params");
const params = computed(() => data.props?.params ?? {});




const startY = ref(0)
const translateY = ref(0)
const allowPullDown = ref(false)

const scrollable = ref(null)
const threshold = 100

function onTouchStart(e) {
  startY.value = e.touches[0].clientY
  const el = scrollable.value
  allowPullDown.value = el.scrollTop === 0
}

function onTouchMove(e) {
  if (!allowPullDown.value) return
  const deltaY = e.touches[0].clientY - startY.value
  if (deltaY > 0) {
    //e.preventDefault() // 防止 iOS 触发橡皮筋 下拉应该没有影响吧
    translateY.value = deltaY
  }
}

function onTouchEnd() {
  if (!allowPullDown.value) return
  if (translateY.value > threshold) {
    notifyParent();
  } else {
    translateY.value = 0
  }
}


</script>

<style lang="scss" scoped>

</style>
