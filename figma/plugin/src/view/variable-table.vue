<script setup>

const params = defineProps({props: null,});
</script>

<template>
  <table>
    <thead>
    <tr>
      <th>key</th>
      <th>mode1</th>
      <th>mode2</th>
      <th>style</th>
      <th>action</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>test</td>
      <td>test</td>
      <td>test</td>
      <td>style</td>
      <td><span class="material-outlined">close</span></td>
    </tr>
    </tbody>
  </table>
</template>

<style lang="scss" scoped>

table {
  border: 1px solid var(--border);
  border-collapse: collapse;
  width: 100%;
}

th, td {
  border: 1px solid var(--border); /* 边框样式 */
  padding: 8px; /* 单元格内边距 */
  padding: 4px; /* 单元格内边距 */
  text-align: left; /* 左对齐文本 */
}
</style>