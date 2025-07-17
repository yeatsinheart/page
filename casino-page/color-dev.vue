<script setup>

// linear-gradient(to right bottom, rgb(249, 89, 89), rgb(255, 154, 142))
// 容器类
const container=ref({
  white:{
    font:{title:'#323233',sub_title:'#646566',normal:'#737272',placeholder:'#969799',disabled:'#BBBBBB'},
    // bg font border shadow
    browser:{bg:'#9195a3'},
    page:{bg:'#f7f8ff',border:'rgba(227, 227, 227, .1)',shadow:'rgba(65,69,73,0.25)'},
    gap:{bg:'#0e131b',font:'#adb6c4'},
    reverse:{bg:'#0e131b',font:'#adb6c4'},
    mask:{bg:'rgba(0, 0, 0, 0.12)'},
    card:{bg:'#ffffff',border:'rgba(227, 227, 227, .1)'},
    div1:{bg:'#f6f6f6'},
    div2:{bg:'#E4E4E4'},
    bar_top:{bg:'#ffffff',font:'#768096'},
    bar_bottom:{bg:'#ffffff',font:'#768096'},
    grid:{shadow:'rgba(65,69,73,0.25)'},
    input:{shadow:'rgba(65,69,73,0.25)'},
  },
  black1:{
    font:{title:'#FFFFFF',sub_title:'#FFFFFF',normal:'#adb6c4',placeholder:'#55657e',disabled:'#BBBBBB'},
    // bg font border shadow
    browser:{bg:'#293549'},
    page:{bg:'#0e131b',border:'rgba(227, 227, 227, .1)',shadow:'rgba(0, 0, 0, 0.24)'},
    focus:{bg:'#404041'},
    gap:{bg:'#f7f8ff',font:'#737272'},
    reverse:{bg:'#f7f8ff',font:'#737272'},
    mask:{bg:'rgba(0, 0, 0, 0.12)'},
    card:{bg:'#141d29',border:'#293549'},
    div1:{bg:'#0f0e0e'},
    div2:{bg:'#000000'},
    bar_top:{bg:'#141d29',font:'#adb6c4'},
    bar_bottom:{bg:'#111923',font:'#7d8ba1'},
    grid:{shadow:'rgba(0,0,0,0.1)'},
    input:{shadow:'rgba(65,69,73,0.25)'},
  },
  black2:{
    font:{title:'#FFFFFF',sub_title:'#FFFFFF',normal:'#adb6c4',placeholder:'#55657e',disabled:'#BBBBBB'},
    // bg font border shadow
    browser:{bg:'#293549'},
    page:{bg:'#333333',border:'rgba(227, 227, 227, .1)',shadow:'rgba(0, 0, 0, 0.24)'},
    focus:{bg:'#404041'},
    gap:{bg:'#f7f8ff',font:'#737272'},
    reverse:{bg:'#f7f8ff',font:'#737272'},
    mask:{bg:'rgba(0, 0, 0, 0.12)'},
    card:{bg:'#141d29',border:'#293549'},
    div1:{bg:'#0f0e0e'},
    div2:{bg:'#000000'},
    bar_top:{bg:'#141d29',font:'#adb6c4'},
    bar_bottom:{bg:'#111923',font:'#7d8ba1'},
    grid:{shadow:'rgba(0,0,0,0.1)'},
    input:{shadow:'rgba(65,69,73,0.25)'},
  },
  black3:{
    font:{title:'#FFFFFF',sub_title:'#FFFFFF',normal:'#adb6c4',placeholder:'#55657e',disabled:'#BBBBBB'},
    // bg font border shadow
    browser:{bg:'#293549'},
    page:{bg:'#161823',border:'rgba(227, 227, 227, .1)',shadow:'rgba(0, 0, 0, 0.24)'},
    focus:{bg:'#404041'},
    gap:{bg:'#f7f8ff',font:'#737272'},
    reverse:{bg:'#f7f8ff',font:'#737272'},
    mask:{bg:'rgba(0, 0, 0, 0.12)'},
    card:{bg:'#141d29',border:'#293549'},
    div1:{bg:'#0f0e0e'},
    div2:{bg:'#000000'},
    bar_top:{bg:'#141d29',font:'#adb6c4'},
    bar_bottom:{bg:'#111923',font:'#7d8ba1'},
    grid:{shadow:'rgba(0,0,0,0.1)'},
    input:{shadow:'rgba(65,69,73,0.25)'},
  },
})
// 主题类
const theme=ref({
  草绿:{color:'rgb(13, 141, 66)',font:'#ffffff'},//草绿
  blue:{color:'#005DFE',font:'#ffffff'},
  皇家蓝:{color:'rgb(28, 87, 203)',font:'#ffffff'},//皇家蓝
  高贵蓝:{color:'rgb(20, 34, 60)',font:'#ffffff'},//高贵蓝
  金麒麟:{color:'rgb(191, 131, 1)',font:'#ffffff'},//金麒麟
  紫罗兰:{color:'rgb(136, 18, 190)',font:'#ffffff'},//紫罗兰
  pink:{color:'#f95959',font:'#ffffff'},
  珊瑚:{color:'rgb(238, 79, 23)',font:'#ffffff'},//珊瑚
  红橙:{color:'rgb(200, 52, 6)',font:'#ffffff'},//红橙
  酒红:{color:'rgb(222, 47, 4)',font:'#ffffff'},//酒红
  罂粟红:{color:'rgb(184, 1, 1)',font:'#ffffff'},//罂粟红
})
// 配色
const colors=ref({
  color1:{color:'#4169e1',font:'#ffffff'},
  color2:{color:'#00fe00',font:'#ffffff'},
  color3:{color:'#ffde53',font:'#ffffff'},
  danger:{color:'#D23838',font:'#ffffff'},
})


</script>

<template>
  <div class="browser">
    <div class="page">
      <div class="card"></div>
      <div class="gap"></div>
      <div class="card">
        <div class="div1"></div>
        <div class="div1">
          <div class="div2"></div>
        </div>
      </div>
      <div class="theme"></div>
    </div>
  </div>
</template>

<style scoped lang="scss">

</style>