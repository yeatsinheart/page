<template>
  <div class="maintain">
    <p class="en-title">{{ $t("System maintenance") }}</p>
    <p class="title">{{ $t("系统维护中") }}</p>
    <img src="" alt="" />
    <p>{{ $t("To bring you a better experience") }}</p>
    <p>{{ $t("We are undergoing maintenance") }}</p>
    <p>{{ $t("Please check back later. Thank you!") }}</p>
    <p>{{ $t("为了给您带来更好的体验") }}</p>
    <p>{{ $t("我们正在进行维护") }}</p>
    <p>{{ $t("请稍后回来查看。谢谢！") }}</p>
    <div class="foot">
      <p>
        {{ $t("Maintenance time is") }}
        2024-11-12 至 2024-11-30
      </p>
      <p>
        {{ $t("维护时间为") }}
        2024-11-12 至 2024-11-30
      </p>
    </div>
  </div>
</template>

<script setup></script>

<style lang="scss" scoped>
.maintain {
  text-align: center;
  padding: 12px;
  font-size: 25px;
  height: 100%;
  width: 100%;
  //   background: linear-gradient(to bottom, #add8e6, #ffffff, #add8e6);
  overflow-y: auto;
}
p {
  line-height: 45px;
}
.en-title {
  margin-top: 30px;
  font-size: var(--f4);
}
img {
  height: 200px;
  width: 100px;
  margin: 20px 0;
}
.foot {
  text-align: center;
  margin-top: 200px;
}
</style>
