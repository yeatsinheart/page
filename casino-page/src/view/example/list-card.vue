<script setup>
const updateColumns = () => {
  const container = document.querySelector('.col');
  if (!container) return;
  const width = container.offsetWidth;
  let cols = 1;
  if (width > 1000) cols = 6;
  else if (width > 800) cols = 5;
  else if (width > 600) cols = 4;
  else if (width > 400) cols = 3;
  else cols = 2;
  container.style.setProperty('--columns', cols);
};
onMounted(()=>{
  const container = document.querySelector('.col');
  if (container) {
    new ResizeObserver(updateColumns).observe(container);
  }
// 初始执行一次
  updateColumns();
})
</script>

<template>
  <div class="col">
    <slot/>
  </div>
</template>

<style scoped lang="scss">

</style>