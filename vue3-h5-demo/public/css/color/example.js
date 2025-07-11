function by_arae(name,font,bg,border,shadow) {
    console.log("--"+name+"-font:"+font+";");
    console.log("--"+name+"-bg:"+bg+";");
    console.log("--"+name+"-border:"+border+";");
    console.log("--"+name+"-shadow:"+shadow+";");
}
function colors(...args) {
    return "";
}
function font_bg(title,sub_title,info,mark,placeholder,disabled) {
    return "";
}

function font_function(link,hover,focus,action,success,warn,err) {
    return "";
}
// 白底/亮底 黑底/暗底
colors("#1989fa","#04BE02","#07c160","#fff","#000","#faab0c","#ee0a24")
font_bg("#323233","#646566","#34495e","#969799","#bbb","#bbb")
font_function("#323233","#646566","#969799","#969799","#fff","#000","#bbb","#bbb")

// 2px 2px 10px rgba(0, 0, 0, 0.1)
// rgba(0, 0, 0, 0.08) 0px 3px 5px
// 区块
// linear-gradient(transparent, rgba(1, 1, 1, 0.8))
by_arae("browser","#bbb","#eff2f5",null,null)//浏览器
by_arae("page","#969799","#eceff3",null,null)//通用页面

by_arae("loading","#2f85da","#ecf9ff","#fff","#fff")//引用

// 层级区块
by_arae("card","#969799","#fff","#e4e7ed","#rgba(0, 0, 0, 0.08)")
by_arae("div1","#969799","#fff","#e4e7ed","#rgba(0, 0, 0, 0.08)")

// 功能分区
by_arae("bar-top","#969799","#fff","#e4e7ed","#rgba(0, 0, 0, 0.08)")//导航栏
by_arae("bar-bottom","#969799","#fff","#e4e7ed","#rgba(0, 0, 0, 0.08)")//导航栏
by_arae("menu","#fff","#fff","#fff","#fff")//菜单栏

by_arae("main","#fff","#fff","#fff","#fff")//主题色区域
by_arae("main_reverse","#fff","#fff","#fff","#fff")//主题色反区域

by_arae("notify","#fff","#fff","#fff","#fff")//消息提醒
by_arae("tag","#fff","#fff","#fff","#fff")//标签 统计提醒 小圆点

by_arae("badge","#fff","#ee0a24","#fff","#fff")//标签 统计提醒 小圆点

by_arae("list","#fff","#fff","#fff",null)//行排列
by_arae("grid","#fff","#fff","#fff","#rgba(0, 0, 0, 0.1)")//宫格

by_arae("reverse","#fff","#000","#fff","#000")//反差
by_arae("quote","#2f85da","#ecf9ff","#fff","#fff")//引用
by_arae("input","#2f85da","#ecf9ff","#fff","#fff")//输入
by_arae("send","#2f85da","#ecf9ff","#fff","#fff")//发送按钮

// color：警告 通知 成功 失败
by_arae("danger","#2f85da","#ee0a24","#fff","#fff")//引用
by_arae("warn","#2f85da","#ff976a","#fff","#fff")//引用
by_arae("success","#2f85da","#07c160","#fff","#fff")//引用
by_arae("info","#2f85da","#ecf9ff","#fff","#fff")//引用

by_arae("scrollbar","#2f85da","#ecf9ff","#fff","#fff")//引用
by_arae("scroll-","#2f85da","#ecf9ff","#fff","#fff")//引用

by_arae("hover","#2f85da","#ecf9ff","#fff","#fff")//引用
by_arae("focus","#2f85da","#ecf9ff","#fff","#fff")//引用

console.log({})
