/*
library themme;

export 'style-text.dart';
export 'button-elevated.dart';
export 'button-icon.dart';
export 'button-style-text.dart';
*/

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/theme/style-text.dart';

import 'style-button.dart';

/// 如果有缓存，那么需要使用缓存数据。怎么判断有没有缓存，或者某key为空时。。
ThemeData getFlutterTheme() {
  return ThemeData(
    useSystemColors:false,// 某些控件会变成浏览器原生行为（比如 <button>）；
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: AppStyle.getMainColor(),
    // colorSchemeSeed:Colors.red,
    // colorScheme:ColorScheme(),
    // primarySwatch:MaterialColor(),
    // applyElevationOverlayColor:false,

    // 点击时的高亮效果设置为透明 长按时的扩散效果设置为透明 以上两者去除按钮点击水波纹
    splashFactory: NoSplash.splashFactory,// final bool useInkSparkle = platform == TargetPlatform.android && !kIsWeb;splashFactory ?? useMaterial3? useInkSparkle? InkSparkle.splashFactory: InkRipple.splashFactory: InkSplash.splashFactory;

    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    // materialTapTargetSize:MaterialTapTargetSize.padded,
    // COLOR
    // brightness:Brightness(),
    // [colorScheme] is the preferred way to configure colors. The [Color] properties
    // listed below (as well as primarySwatch) will gradually be phased out, see
    // https://github.com/flutter/flutter/issues/91772.
    // canvasColor:Colors.red,
    // cardColor:Colors.red,
    // disabledColor:Colors.red,
    // dividerColor:Colors.red,
    // focusColor:Colors.red,
    // hintColor:Colors.red,
    // primaryColorDark:Colors.red,
    // primaryColorLight:Colors.red,
    // secondaryHeaderColor:Colors.red,
    // shadowColor:Colors.red,
    // unselectedWidgetColor:Colors.red,
    /// 文件夹中添加对应组件的theme获取方法
    scrollbarTheme:ScrollbarThemeData(),
    textTheme: getTextTheme(),
    textButtonTheme: TextButtonThemeData(style:globalButtonStyle()),

    iconTheme:IconThemeData(color: Colors.red),
    iconButtonTheme: IconButtonThemeData(style: globalButtonStyle()),
    elevatedButtonTheme: ElevatedButtonThemeData(style: globalButtonStyle()),

    // GENERAL CONFIGURATION
    // adaptations:<Adaptation<Object>>[],
    //cupertinoOverrideTheme:cupertinoOverrideTheme?.noDefault(),//NoDefaultCupertinoThemeData?
    // extensions:<ThemeExtension<dynamic>>[],//Iterable<ThemeExtension<dynamic>>?
    // inputDecorationTheme:const InputDecorationTheme(),
    // pageTransitionsTheme:const PageTransitionsTheme(),
    // platform:defaultTargetPlatform,//TargetPlatform?
    // visualDensity:VisualDensity.defaultDensityForPlatform(defaultTargetPlatform),
    // TYPOGRAPHY & ICONOGRAPHY
    // String? fontFamily,
    // List<String>? fontFamilyFallback,
    // String? package,
    // IconThemeData? primaryIconTheme,
    // TextTheme? primaryTextTheme,
    // Typography? typography,
    //
    // COMPONENT THEMES
    // actionIconTheme:ActionIconThemeData(),
    // appBarTheme:AppBarTheme(),
    // badgeTheme:BadgeThemeData(),
    // bannerTheme:MaterialBannerThemeData(),
    // bottomAppBarTheme:BottomAppBarTheme(),
    // bottomNavigationBarTheme:BottomNavigationBarThemeData(),
    // bottomSheetTheme:BottomSheetThemeData(),
    // buttonTheme:ButtonThemeData(),
    // cardTheme:CardThemeData(),
    // checkboxTheme:CheckboxThemeData(),
    // chipTheme:ChipThemeData(),
    // dataTableTheme:DataTableThemeData(),
    // datePickerTheme:DatePickerThemeData(),
    // dialogTheme:DialogThemeData(),
    // dividerTheme:DividerThemeData(),
    // drawerTheme:DrawerThemeData(),
    // dropdownMenuTheme:DropdownMenuThemeData(),
    // expansionTileTheme:ExpansionTileThemeData(),
    // filledButtonTheme:FilledButtonThemeData(),
    // floatingActionButtonTheme:FloatingActionButtonThemeData(),
    // listTileTheme:ListTileThemeData(),
    // menuBarTheme:MenuBarThemeData(),
    // menuButtonTheme:MenuButtonThemeData(),
    // menuTheme:MenuThemeData(),
    // navigationBarTheme:NavigationBarThemeData(),
    // navigationDrawerTheme:NavigationDrawerThemeData(),
    // navigationRailTheme:NavigationRailThemeData(),
    // outlinedButtonTheme:OutlinedButtonThemeData(),
    // popupMenuTheme:PopupMenuThemeData(),
    // progressIndicatorTheme:ProgressIndicatorThemeData(),
    // radioTheme:RadioThemeData(),
    // searchBarTheme:SearchBarThemeData(),
    // searchViewTheme:SearchViewThemeData(),
    // segmentedButtonTheme:SegmentedButtonThemeData(),
    // sliderTheme:SliderThemeData(),
    // snackBarTheme:SnackBarThemeData(),
    // switchTheme:SwitchThemeData(),
    // tabBarTheme:TabBarThemeData(),
    // textSelectionTheme:TextSelectionThemeData(),
    // timePickerTheme:TimePickerThemeData(),
    // toggleButtonsTheme:ToggleButtonsThemeData(),
    // tooltipTheme:TooltipThemeData(),

    // For the sanity of the reader, make sure these properties are in the same
    // order in every place that they are separated by section comments (e.g.
    // GENERAL CONFIGURATION). Each section except for deprecations should be
    // alphabetical by symbol name.


    // DEPRECATED (newest deprecations at the bottom)
    /*@Deprecated(
    'Use OverflowBar instead. '
    'This feature was deprecated after v3.21.0-10.0.pre.',
    )
    ButtonBarThemeData? buttonBarTheme,
    @Deprecated(
    'Use DialogThemeData.backgroundColor instead. '
    'This feature was deprecated after v3.27.0-0.1.pre.',
    )
    Color? dialogBackgroundColor,
    @Deprecated(
    'Use TabBarThemeData.indicatorColor instead. '
    'This feature was deprecated after v3.28.0-1.0.pre.',
    )
    Color? indicatorColor,
*/

  );
}
