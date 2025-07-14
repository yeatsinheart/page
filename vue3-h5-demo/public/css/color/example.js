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
// 需要的颜色特别标注（功能，位置）出来：特殊字色 特殊颜色
colors("#1989fa","#04BE02","#07c160","#fff","#000","#faab0c","#ee0a24")
font_bg("#323233","#646566","#34495e","#969799","#bbb","#bbb")
font_function("#323233","#646566","#969799","#969799","#fff","#000","#bbb","#bbb")

// 2px 2px 10px rgba(0, 0, 0, 0.1)
// rgba(0, 0, 0, 0.08) 0px 3px 5px
// 区块
// linear-gradient(transparent, rgba(1, 1, 1, 0.8))

// 按照位置/功能 进行分类。。
by_arae("browser","#bbb","#eff2f5",null,null)//浏览器
by_arae("page","#969799","#f7f8fa",null,null)//通用页面

by_arae("scrollbar","#2f85da","#ecf9ff","#fff","#fff")//引用
by_arae("scrollbar-track",null,"rgba(9, 38, 180, 0.8)",null,null)//引用
by_arae("scrollbar-thumb",null,"red",null,"rgba(9, 38, 180, 0.8)")//引用
by_arae("scrollbar-thumb-hover",null,"rgba(0, 0, 0, 0.53)",null,"rgba(9, 38, 180, 0.8)")//引用
/*

::-webkit-scrollbar {
       height: 7px;
       display: block;
   }

//定义滚动条轨道 内阴影+圆角
* ::-webkit-scrollbar-track {
    border-radius: 10px;
    background-color:  rgba(9, 38, 180, 0.8);
    //red;
    //rgba(0, 0, 0, 0.3);
}

//定义滑块 内阴影+圆角
* ::-webkit-scrollbar-thumb {
    border-radius: 10px;
    -webkit-box-shadow: inset 0 0 6px rgba(9, 38, 180, 0.8);
    background-color:  red;
&:hover {
        background-color: rgba(0, 0, 0, 0.53);
        cursor: pointer;
    }
}

* */

by_arae("x-hover","#2f85da","#ecf9ff","#fff","#fff")//引用
by_arae("x-focus","#2f85da","#ecf9ff","#fff","#fff")//引用

by_arae("reverse","#fff","#000","#fff","#000")//反差
by_arae("card","#969799","#fff","#e4e7ed","rgba(0, 0, 0, 0.08)")
by_arae("div1","#969799","#f3f2f5","#e4e7ed","rgba(0, 0, 0, 0.08)")

by_arae("toast","#2f85da","#ecf9ff","#fff","#fff")//
// 功能分区
by_arae("bar-top","#969799","#fff","#e4e7ed","#rgba(0, 0, 0, 0.08)")//导航栏
by_arae("bar-bottom","#969799","#fff","#e4e7ed","#rgba(0, 0, 0, 0.08)")//导航栏
by_arae("main","#fff","#fff","#fff","#fff")//主题色区域
by_arae("main_reverse","#fff","#fff","#fff","#fff")//主题色反区域

by_arae("menu","#fff","#fff","#fff","#fff")//菜单栏

by_arae("notify","#fff","#fff","#fff","#fff")//消息提醒
by_arae("tag","#fff","#fff","#fff","#fff")//标签 统计提醒 小圆点
by_arae("badge","#fff","#ee0a24","#fff","#fff")//标签 统计提醒 小圆点
by_arae("list","#fff","#fff","#fff",null)//行排列
by_arae("grid","#fff","#fff","#fff","#rgba(0, 0, 0, 0.1)")//宫格
by_arae("quote","#2f85da","#ecf9ff","#fff","#fff")//引用
by_arae("input","#2f85da","#ecf9ff","#fff","#fff")//输入
by_arae("send","#2f85da","#ecf9ff","#fff","#fff")//发送按钮

// color：警告 通知 成功 失败
by_arae("danger","#2f85da","#ee0a24","#fff","#fff")//引用
by_arae("warn","#2f85da","#ff976a","#fff","#fff")//引用
by_arae("success","#2f85da","#07c160","#fff","#fff")//引用
by_arae("info","#2f85da","#ecf9ff","#fff","#fff")//引用

console.log({})
