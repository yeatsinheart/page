
figma.showUI(__html__, {width: 375,height: 640});
// 最大为 960px，再大也不会显示更宽。
// Figma 插件弹出的 UI 界面（showUI()）高度最大限制为 640 像素（截至 2025 年的官方限制），否则超出的部分将被裁剪并可能出现滚动条。
figma.ui.onmessage = (msg) => {
  if (msg.type === 'resize') {
    figma.ui.resize(msg.width, msg.height);
  }
};

figma.showUI(`<script>window.close()</script>`, { visible: false });

// 本地模拟 JSON 文件
//const tokens = require("./tokens.json");

//const { collectionName, modes, variables } = tokens;

// 创建变量集合figma.showUI(`<script>window.close()</script>`, { visible: false });

function ensureModes(collection: VariableCollection, modeNames: string[]) {
  const existingModeNames = new Set(collection.modes.map(m => m.name));
  for (const modeName of modeNames) {
    if (!existingModeNames.has(modeName)) {
        // 你不能自己去构造 modeId，只能让 collection.addMode() 自动生成或你传入旧的。
      collection.addMode(modeName);
      console.log(`➕ 添加 mode: ${modeName}`);
    } else {
      console.log(`✅ 已存在 mode: ${modeName}`);
    }
  }
}

const collection = figma.variables.getLocalVariableCollections()
  .find(c => c.name === collectionName) ?? figma.variables.createVariableCollection(collectionName);

//["light","dark"]
ensureModes(collection,modes);
// 重新获取modes

// ✅ 必须重新获取，才能拿到新的 modeId
const updatedModes = collection.modes;

         // 创建变量并设置值 'COLOR' | 'FLOAT' | 'STRING' | 'BOOLEAN'
         for (const token of variables) {
             let variable = collection.variables.find(v => v.name === token.name && v.type === token.type);
             if (!variable) {
                variable = figma.variables.createVariable(token.name, token.type as VariableResolvedDataType, collection.id);
             }
           for (const mode of modes) {
             const value = token.values[mode];
             if (value !== undefined) {
                const modeId = collection.modes.find(m => m.name === mode)?.modeId;
                if (modeId) {
                    // 如果 改模式，json中没有配置，则设置一个默认值
                  variable.setValueForMode(modeId, { r: 1, g: 0, b: 0 }); // 设置为红色
                }
             }
           }
         }
         figma.closePlugin(`导入完成，共 ${variables.length} 个变量`);

// 如果是Color的，自动绑定颜色样式
function createOrUpdatePaintStyle(name: string, paint: Paint) {
  // 查找是否已存在同名 PaintStyle
  const existing = figma.getLocalPaintStyles().find(style => style.name === name);
  if (existing) {
    // 如果已存在，更新它
    existing.paints = [paint];
    return existing;
  } else {
    // 否则创建新的
    const paintStyle = figma.createPaintStyle();
    paintStyle.name = name;
    paintStyle.paints = [paint];
    return paintStyle;
  }
}

/*

 figma.ui.onmessage = async (msg) => {
   if (msg.type === 'import-json') {
     try {

       figma.notify("变量导入成功");
     } catch (e) {
       figma.notify("导入失败，请检查 JSON 格式");
     } finally {
       figma.closePlugin();
     }
   }
 };


 figma.ui.onmessage = async (msg) => {
   if (msg.type === 'import-styles') {
     try {
       const styles = JSON.parse(msg.data);
       for (const name in styles) {
         const hex = styles[name];
         const paintStyle = figma.createPaintStyle();
         paintStyle.name = name;
         paintStyle.paints = [{
           type: 'SOLID',
           color: hexToRgb(hex)
         }];
         // 引用变量的写法
         const paintStyle = figma.createPaintStyle();
             paintStyle.name = 'My Style Using Variable';
             paintStyle.boundVariables = {
               color: myColorVariable.id // 注意：这里不是 paints，而是 boundVariables
             };
       }

       figma.notify("颜色样式已导入");
     } catch (e) {
       figma.notify("JSON 格式错误");
     } finally {
       figma.closePlugin();
     }
   }
 };



 */
/*

比如带“🗑 删除”按钮，我也可以帮你写完整逻辑，包括提示确认等。


 🔧 删除样式的代码方式
 Figma 插件可以通过 API 删除样式，例如：

 删除颜色样式
 ts
 复制
 编辑
 const style = figma.getLocalPaintStyles().find(s => s.name === 'My Style');
 if (style) {
   style.remove(); // 删除样式
 }
 删除文本样式
 ts
 复制
 编辑
 const textStyle = figma.getLocalTextStyles().find(s => s.name === 'My Text Style');
 if (textStyle) {
   textStyle.remove();
 }
 删除效果样式
 ts
 复制
 编辑
 const effectStyle = figma.getLocalEffectStyles().find(s => s.name === 'My Effect Style');
 if (effectStyle) {
   effectStyle.remove();
 }


 1. ✅ 删除变量（Variable）
 你可以调用 variable.remove() 来删除某个变量：

 ts
 复制
 编辑
 const variable = figma.variables.getLocalVariables().find(v => v.name === 'My Variable');
 if (variable) {
   variable.remove();
 }

 删除变量集合（VariableCollection）
 你可以调用 collection.remove() 来删除一个变量集合：

 ts
 复制
 编辑
 const collection = figma.variables.getLocalVariableCollections().find(c => c.name === 'My Collection');
 if (collection) {
   collection.remove();
 }
 ⚠️ 需要先确保集合下的变量都已删除，否则可能会报错。


 删除 Mode（mode 模式）
 可以使用 collection.removeMode(modeId) 来删除集合下的某个 mode：

 ts
 复制
 编辑
 const collection = figma.variables.getLocalVariableCollections().find(c => c.name === 'My Collection');
 if (collection) {
   const modeToDelete = collection.modes.find(m => m.name === 'Dark');
   if (modeToDelete) {
     collection.removeMode(modeToDelete.modeId);
   }
 }

 */
