<script setup>
import TableLayout from "@/view/example/table/table-layout.vue";
import {shortcuts} from "@/tool/date.js";
import {xlsx} from "@/tool/excel.js";

const chosenIds = ref([])

const search = ref({})
const more_search_show = ref(false)

const list = ref([])
const tableId = ref('xxx')
const pagination = ref({page: 1, size: 50, total: 1000000000});

function query(){
  pagination.value.total=1000000000+1;
}

function excel(){
  xlsx(list,'test')
}

</script>

<template>
  <TableLayout :query="query" :excel="excel" :table-id="tableId" :chosen-ids="chosenIds" :pagination="pagination" :list="list">
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
      <div v-if="chosenIds.length > 0" style="padding-top: 5px;">
        <el-button size="small">启用</el-button>
        <el-button size="small">禁用</el-button>
        <el-button size="small">备注</el-button>
      </div>
    </template>


    <template  #column>
      <el-table-column type="selection" width="20"/>
      <el-table-column prop="recharge" label="用户名"  show-overflow-tooltip/>
      <el-table-column prop="recharge" label="密码"  show-overflow-tooltip/>
      <el-table-column prop="recharge" label="备注"  show-overflow-tooltip/>
      <el-table-column prop="recharge" label="注册日期"  show-overflow-tooltip/>
      <el-table-column prop="recharge" label="操作日期"  show-overflow-tooltip/>
    </template>


    <template #data>统计数据</template>
  </TableLayout>
</template>

<style scoped lang="scss">

:deep(.el-input-group__append){
  padding:0 5px!important;
}
</style>