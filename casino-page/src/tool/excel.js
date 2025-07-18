import * as XLSX from "xlsx";

/*最大104万行*/
export function xlsx(list,filename) {
    // 1. 生成工作簿和工作表
    const ws = XLSX.utils.json_to_sheet(list);
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "数据");

    // 2. 导出 Excel 文件
    XLSX.writeFile(wb, filename+".xlsx");
}
//
// 适用场景
// 数据量 10 万 ~ 100 万条
async function exportExcel(headers,types,filename) {
    let pageNum = 1;
    let hasMoreData = true;
    const wb = XLSX.utils.book_new(); // 创建 Excel 工作簿
    const ws = XLSX.utils.aoa_to_sheet(headers,types); // 创建空的 Sheet
    // 设置格式
    ws["A2"].z = "yyyy-mm-dd"; // 日期格式
    ws["B2"].z = "$#,##0.00"; // 货币格式
    ws["C2"].t = "n"; // 数字
    ws["D2"].t = "s"; // 纯文本

    // 遍历所有行，统一修改某列的格式
    const range = XLSX.utils.decode_range(ws["!ref"]); // 获取范围
    for (let R = 1; R <= range.e.r; ++R) {
        const cellDate = ws[XLSX.utils.encode_cell({ r: R, c: 0 })]; // A列（日期）
        const cellPrice = ws[XLSX.utils.encode_cell({ r: R, c: 1 })]; // B列（价格）
        // z 仅在 Excel 打开时生效，不会影响数据本身。
        if (cellDate) cellDate.z = "yyyy-mm-dd"; // 设置日期格式
        if (cellPrice) cellPrice.z = "$#,##0.00"; // 设置货币格式
    }
    // 预设 Excel 样式
    ws["!cols"] = [
        { wch: 15 }, // 第一列（日期）宽度 15
        { wch: 10, z: "$#,##0.00" }, // 第二列（价格）格式化为货币
        { wch: 8, t: "n" }, // 第三列（数量）设为数字
        { wch: 20, t: "s" }, // 第四列（文本）设为字符串
    ];

    while (hasMoreData) {
        console.log(`正在获取第 ${pageNum} 页数据...`);

        try {
            // **1. 分页请求数据**
            const response = await fetch(`/api/export?page=${pageNum}&size=${this.pageSize}`);
            const result = await response.json();
            const data = result.data || [];

            if (data.length > 0) {
                // **2. 逐步写入 Sheet，而不是存到变量**
                appendDataToSheet(ws, data, pageNum === 1);

                pageNum++; // 获取下一页
            } else {
                hasMoreData = false; // 没有更多数据
            }
        } catch (error) {
            console.error("数据获取失败:", error);
            hasMoreData = false;
        }
    }

    console.log("数据获取完成，开始导出 Excel...");
    // **3. 生成 Excel 并下载**
    XLSX.utils.book_append_sheet(wb, ws, "数据");
    XLSX.writeFile(wb, filename+".xlsx");

    console.log("Excel 导出完成！");
}

function appendDataToSheet(sheet, data, isFirstPage) {
    // **如果是第一页，写入表头**
    if (isFirstPage) {
        const headers = Object.keys(data[0]);
        XLSX.utils.sheet_add_aoa(sheet, [headers], { origin: "A1" });
    }
    // **追加数据，不存到变量，直接写入 Sheet**
    const values = data.map(item => Object.values(item));
    XLSX.utils.sheet_add_aoa(sheet, values, { origin: -1 });
}