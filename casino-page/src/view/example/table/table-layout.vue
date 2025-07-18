<script setup>
const params = defineProps({
  pagination: {type: Object,required: true,default: {page: 1, size: 50, total: 1000000000}},
  list:{type: Array,required: true,default:()=>[]},
  query: {type: Function,required: true,},
  excel: {type: Function,required: true,},
  tableId:{type: String,required: true,},
  chosenIds:{type: Array,required: true,}
})
const list = ref([])
const chosenIds = ref([])
const pagination = ref({page: 1, size: 50, total: 1000000000});
onBeforeMount(()=>{
  list.value = params.list
  pagination.value = params.pagination
})

const emit = defineEmits(['update:pagination','update:chosenIds'])
// 监听父组件更新，同步更新内部数据
watch(() => params.pagination,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(pagination.value)) {
        pagination.value = newVal;
      }
    }
);
watch(() => params.list,
    (newVal) => {
      if (JSON.stringify(newVal) !== JSON.stringify(list.value)) {
        list.value = newVal;
      }
    }
);

// 监听 pagination 的变化
watch(pagination, (newVal) => {
  if (JSON.stringify(newVal) !== JSON.stringify(params.pagination)) {
    emit('update:pagination', newVal);
  }
});

// 监听 pagination 的变化
watch(chosenIds, (newVal) => {
  if (JSON.stringify(newVal) !== JSON.stringify(params.chosenIds)) {
    emit('update:chosenIds', newVal);
  }
});


//  watch(() => [变量1, 变量2], callback) 监听 currentPage 和 pageSize 的变化 immediate: true 加载就搜索
watch(() => [pagination.value.page, pagination.value.size], // 监听数组
    async (newValue, oldValue) => {
      if(oldValue && newValue[1]!==oldValue[1]){
        pagination.value.page=1;return;
      }
      chosenIds.value = [];
      await params.query();
    },
    { immediate: true }
);

const handleSelectionChange = (rows, ignoreSelectable) => {
  chosenIds.value = rows.map(row => row[params.tableId]);
}
const table = ref()
const toggleSelection = (row) => {
  const index = chosenIds.value.findIndex(item => item === row[params.tableId]);
  table.value.toggleRowSelection(row,index === -1)
}
/*function query(){
  list.value = [];
  pagination.value.total = 0;
}*/
</script>

<template>
  <div style="padding: 4px;height:100%;">
    <div class="flex-column page" style="">
      <!--搜索栏-->
      <div v-if="$slots.header" style="width:100%;padding: 4px;">
        <slot name="header"></slot>
        <div class="border"></div>
      </div>
      <!--表格数据栏-->
      <div v-if="$slots.column" style="width:100%;height:100%;overflow: auto;padding: 4px;">
        <el-auto-resizer v-slot="{ height, width }">
          <el-table ref="table"
                    :data="list" :row-key="params.tableId"
                    @row-click="toggleSelection" @selection-change="handleSelectionChange"
                    highlight-current-row stripe :max-height="height" :height="height" style="width: 100%"
          >
            <slot name="column"></slot>
          </el-table>
        </el-auto-resizer>
      </div>
      <!--统计栏-->
      <div v-if="$slots.data" style="width:100%;">
        <div class="border"></div>
        <slot name="data"></slot>
      </div>
      <!--分页工具栏-->
      <div style="width:100%;">
        <div class="border"></div>
        <div style="padding: 4px;width:100%;">
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
            <div @click="params.excel()" style="flex-shrink: 0;">导出Excel</div>
          </div>
        </div>
      </div>

    </div>
  </div>

</template>

<style scoped lang="scss">

.page {
  border: 1px solid var(--border);
  border-radius: 4px;
  height: 100%;
  /* 高度 100% - 2marin 2border */
}

.border {
  height: 1px;width: 100%;
  border-top: 1px solid var(--border);
}

/*整个滚动条*/
*::-webkit-scrollbar {
  height: 7px;width: 5px;display: block; cursor: pointer;
}
/*定义滚动条轨道 内阴影+圆角*/
*::-webkit-scrollbar-track {
  border-radius: 10px;
  background-color:  rgba(9, 38, 180, 0.1);
}
/*定义滑块*/
*::-webkit-scrollbar-thumb {
  border-radius: 10px;
  background-color:  var(--c1);
}



:deep(.el-table){user-select: text;background-color: transparent!important;}
:deep(.el-table--border .el-table__cell){
  border-bottom-color: #ccc!important;
  border-right-color: #ccc!important;
}
:deep(.el-table thead .cell,.el-table tbody .el-table__cell){ padding: 0 0 !important;}
:deep(.el-table tbody .el-table__cell){ padding: 1px 0 !important;}

:deep(.el-table tbody .cell ,.el-table tbody .el-table__cell ,){
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