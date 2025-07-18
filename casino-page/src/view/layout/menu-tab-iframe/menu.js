function node(title,url,icon){
    return {title:title,url:url,icon:icon};
}

const menus = [
    {...node("应用"), children: [
        node("首页","/view/templates?m=key"),
        node("注册登录","/view/templates?m=key"),
        node("表格","/view/example/table/table?m=key"),
    ]},
];
export default menus;
