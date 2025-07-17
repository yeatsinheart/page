function node(title,url,icon){
    return {title:title,url:url,icon:icon};
}

const menus = [
    {...node("应用"), children: [
        node("首页","/view/templates"),
    ]},
];
console.log(menus);
export default menus;
