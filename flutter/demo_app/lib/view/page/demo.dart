import 'package:flutter/material.dart';

import 'package:flutter3/share/safe-state.dart';
// Flutter 中如果属性发生变化则会重新构建Widget树 一旦 Widget 自己的属性变了自己就会被替换
// key，主要的作用是决定是否在下一次build时复用旧的 widget ，决定的条件在canUpdate()方法中。

// widget，它表示与该 State 实例关联的 widget 实例，由Flutter 框架动态设置。
// 注意，这种关联并非永久的，因为在应用生命周期中，UI树上的某一个节点的 widget 实例在重新构建时可能会变化，
// 但State实例只会在第一次插入到树中时被创建，当在重新构建时，如果 widget 被修改了，Flutter 框架会动态设置State. widget 为新的 widget 实例。
// 当 State 对象从树中被永久移除时调用；通常在此回调中释放资源。
class PageDemo extends StatefulWidget {
  const PageDemo({super.key, required params});

  @override
  _PageDemoState createState() => _PageDemoState();
}

// https://blog.csdn.net/jdsjlzx/article/details/125340702
class _PageDemoState extends SafeState<PageDemo> with TickerProviderStateMixin {
  // 标签
  List<Widget> _tabs = [];

  //  内容
  List<Widget> _tab_content = [];
  late TabController _tabController; //注意 在TabBar和TabBarView中都需要配置controller
  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
    // 这里会
    initTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        //backgroundColor: GlobalContext.color(),
        actions: <Widget>[
          IconButton(
            //color: GlobalContext.color(),
            //padding: const EdgeInsets.only(right: 12), //const EdgeInsets.fromLTRB(8, 8, 12, 8),
            icon: const Icon(Icons.view_module),
            onPressed: () async {
              //await Navigator.push(context,MaterialPageRoute(builder: (context) => TagEdit()));
            },
          ),
        ],
        title: TabBar(
          //indicatorPadding: EdgeInsets.symmetric(horizontal: 2.0),
          controller: _tabController, // 指示器的高度/厚度
          //indicatorWeight: 2.0,

          //indicatorColor: GlobalContext.color(),
          //labelColor: Colors.redAccent,
          //unselectedLabelColor: Colors.black,

          //labelPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          isScrollable: true, //和文字等宽
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _tab_content),
    );
  }

  void initTags() async {
    List<Widget> bar = [];
    bar.add(Tab(height: 24, text: '热门'));
    bar.add(Tab(height: 24, text: '日本'));
    bar.add(Tab(height: 24, text: 'xx'));
    List<Widget> pages = [Center(child: Text('热门')), Center(child: Text('日本')), Center(child: Text('xx'))];

    _tabs = bar;
    _tab_content = pages;

    _tabController.removeListener(() {});
    _tabController.dispose();

    int defaultIndex = 0;
    _tabController = TabController(initialIndex: defaultIndex, vsync: this, length: _tabs.length);

    setState(() {});

    _tabController.addListener(() {
      //if (_tabController.indexIsChanging) {}
      //点击切换tab的时候执行了一个动画效果，滑动切换的时候是没有的，在这个过程中触发了一次Listener,所以触发了两次addListener方法
      // 解决点击tab执行2次的问题
      if (_tabController.index == _tabController.animation?.value) {
        //实现自定义的功能 防止点击切换时调用两次
        //print(_tabController.index);
        initContent(_tabController.index);
      }
    });
    //通知重绘图
    // 1秒后进入
    initContent(defaultIndex);
  }

  void initContent(index) async {
    // context对象有一个findAncestorStateOfType()方法，该方法可以从当前节点沿着 widget 树向上查找指定类型的 StatefulWidget 对应的 State 对象。
    // 所以在 Flutter 开发中便有了一个默认的约定：如果 StatefulWidget 的状态是希望暴露出的，应当在 StatefulWidget 中提供一个of 静态方法来获取其 State 对象，开发者便可直接通过该方法来获取；
    // 如果 State不希望暴露，则不提供of方法。这个约定在 Flutter SDK 里随处可见。所以，上面示例中的Scaffold也提供了一个of方法，我们其实是可以直接调用它的：
    // https://hongruqi.github.io/2019/01/26/Flutter%20%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3%20State/
    //ShareChooseIdState state = ShareChooseId.of(context);
    //state.choose(index);
    //VideoListByTag d = _tab_content[index];
    //WidgetsBinding.instance.addPostFrameCallback((_) async {
    //  Future.delayed(const Duration(milliseconds: 200), () {
    //    d.visit();
    //  });
    //});

    //DTOListState _open = context.findAncestorStateOfType<DTOListState>()!;
  }
}
