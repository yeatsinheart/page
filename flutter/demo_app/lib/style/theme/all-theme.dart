/*
library themme;

export 'style-text.dart';
export 'button-elevated.dart';
export 'button-icon.dart';
export 'button-style-text.dart';
*/

import 'package:flutter/material.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/theme/checkbox.dart';
import 'package:flutter3/style/theme/input.dart';
import 'package:flutter3/style/theme/list-title.dart';
import 'package:flutter3/style/theme/style-text.dart';

import 'style-button.dart';

ThemeData getFlutterTheme({Color? bgColor, Color? fontColor, Color? borderColor, Color? shadowColor}) {
  return ThemeData(
    useSystemColors: false,
    // 某些控件会变成浏览器原生行为（比如 <button>）；
    useMaterial3: true,

    scaffoldBackgroundColor: Colors.transparent,
    // colorScheme: ColorScheme(
    //   brightness: Brightness.light,     // 亮色模式或暗色模式
    //   primary: AppStore.getMainColor(),              // 主要颜色
    //   onPrimary: Colors.white,           // 主要颜色上的文字或图标颜色
    //   secondary: Colors.amber,           // 次要颜色
    //   onSecondary: Colors.black,         // 次要颜色上的文字颜色
    //   surface: Colors.white,             // 背景色卡片等表面颜色
    //   onSurface: Colors.black,           // 背景色表面颜色上的文字颜色
    //   error: Colors.red,                 // 错误颜色
    //   onError: Colors.white,             // 错误颜色上的文字颜色
    // ),
    // 使用 colorScheme 的现代 Flutter 主题中，它们往往是被弱化或者部分覆盖的，甚至某些控件不再使用这些旧属性。
    // primaryColor: AppStore.getMainColor(),
    // secondaryHeaderColor: AppStore.getMainColor(),
    // hoverColor: AppStore.getMainColor(),
    // focusColor: AppStore.getMainColor(),
    // highlightColor: AppStore.getMainColor(),
    splashColor: AppStyle.getMainColor().withValues(alpha: .05),
    colorScheme: ColorScheme.fromSeed(seedColor: AppStyle.getMainColor()),
    // colorSchemeSeed:Colors.red,
    // colorScheme:ColorScheme(),
    // primarySwatch:MaterialColor(),
    // applyElevationOverlayColor:false,

    // 点击时的高亮效果设置为透明 长按时的扩散效果设置为透明 以上两者去除按钮点击水波纹

    // splashFactory: NoSplash.splashFactory,// final bool useInkSparkle = platform == TargetPlatform.android && !kIsWeb;splashFactory ?? useMaterial3? useInkSparkle? InkSparkle.splashFactory: InkRipple.splashFactory: InkSplash.splashFactory;
    // hoverColor: Colors.transparent,
    // splashColor: Colors.transparent,

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
    ///
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyle.radius)),
      //insetPadding: EdgeInsets.all(AppStore.byRem(.2)),
      backgroundColor: AppStyle.isDark()?Colors.black:Colors.white,
      titleTextStyle: getTextStyle(),
      contentTextStyle: getTextStyle(),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: AppStyle.getMainColor(),
      labelColor: AppStyle.getMainColor(),
      labelStyle: getTextStyle().copyWith(fontWeight: FontWeight.bold),
      unselectedLabelColor: ColorFont.get().txt,
      unselectedLabelStyle: getTextStyle(),
      dividerColor: ColorFont.get().ghost,
    ),
    appBarTheme: AppBarTheme(),
    bottomAppBarTheme: BottomAppBarTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(),

    scrollbarTheme: ScrollbarThemeData(),
    // AppStore.Brightness=="dark"?Colors.white:Colors.black,
    progressIndicatorTheme:ProgressIndicatorThemeData(color: AppStyle.getMainColor(),),

    // 全局光标颜色设置
    textSelectionTheme: TextSelectionThemeData(cursorColor: AppStyle.getMainColor(),selectionColor: AppStyle.getMainColor().withValues(alpha: 0.3),),
    textTheme: getTextTheme(fontColor: fontColor),
    listTileTheme: getListTitleTheme(fontColor: fontColor),
    checkboxTheme: getCheckBoxTheme(fontColor: fontColor),

    iconTheme: IconThemeData(color: fontColor ?? ColorFont.get().txt, fill: 1),

    buttonTheme: ButtonThemeData(padding: EdgeInsetsGeometry.all(0), minWidth: 0, height: 0),
    textButtonTheme: TextButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),
    iconButtonTheme: IconButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),

    inputDecorationTheme: getInputTheme(fontColor: fontColor),

    dividerTheme: DividerThemeData(color: ColorFont.get().ghost,space: AppStyle.byRem(.05)),

    // filledButtonTheme:FilledButtonThemeData(),
    // floatingActionButtonTheme:FloatingActionButtonThemeData(),
    // menuButtonTheme:MenuButtonThemeData(),
    // outlinedButtonTheme:OutlinedButtonThemeData(),
    // segmentedButtonTheme:SegmentedButtonThemeData(),
    // toggleButtonsTheme:ToggleButtonsThemeData(),

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
    // badgeTheme:BadgeThemeData(),
    // bannerTheme:MaterialBannerThemeData(),

    // bottomSheetTheme:BottomSheetThemeData(),
    // cardTheme:CardThemeData(),
    // checkboxTheme:CheckboxThemeData(),
    // chipTheme:ChipThemeData(),
    // dataTableTheme:DataTableThemeData(),
    // datePickerTheme:DatePickerThemeData(),
    // drawerTheme:DrawerThemeData(),
    // dropdownMenuTheme:DropdownMenuThemeData(),
    // expansionTileTheme:ExpansionTileThemeData(),

    // menuBarTheme:MenuBarThemeData(),
    // menuTheme:MenuThemeData(),
    // navigationBarTheme:NavigationBarThemeData(),
    // navigationDrawerTheme:NavigationDrawerThemeData(),
    // navigationRailTheme:NavigationRailThemeData(),
    // popupMenuTheme:PopupMenuThemeData(),
    // radioTheme:RadioThemeData(),
    // searchBarTheme:SearchBarThemeData(),
    // searchViewTheme:SearchViewThemeData(),
    // sliderTheme:SliderThemeData(),
    // snackBarTheme:SnackBarThemeData(),
    // switchTheme:SwitchThemeData(),
    // textSelectionTheme:TextSelectionThemeData(),
    // timePickerTheme:TimePickerThemeData(),
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
