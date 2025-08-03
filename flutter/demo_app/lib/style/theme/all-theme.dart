/*
library themme;

export 'style-text.dart';
export 'button-elevated.dart';
export 'button-icon.dart';
export 'button-style-text.dart';
*/

import 'package:flutter/material.dart';
import 'package:flutter3/style/app-style.dart';
import 'package:flutter3/style/color-font.dart';
import 'package:flutter3/style/theme/checkbox.dart';
import 'package:flutter3/style/theme/list-title.dart';
import 'package:flutter3/style/theme/style-text.dart';

import 'style-button.dart';

ThemeData getFlutterTheme({Color? bgColor, Color? fontColor, Color? borderColor, Color? shadowColor}) {
  return ThemeData(
    useSystemColors: false,
    // 某些控件会变成浏览器原生行为（比如 <button>）；
    useMaterial3: true,

    scaffoldBackgroundColor: Colors.transparent,

    // colorScheme: ColorScheme.fromSeed(seedColor:  AppStyle.getMainColor()),

    primaryColor: AppStyle.getMainColor(),
    secondaryHeaderColor: AppStyle.getMainColor(),
    hoverColor: AppStyle.getMainColor(),
    focusColor: AppStyle.getMainColor(),
    highlightColor: AppStyle.getMainColor(),
    splashColor: AppStyle.getMainColor(),

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
    tabBarTheme: TabBarThemeData(indicatorColor: AppStyle.getMainColor()),
    appBarTheme: AppBarTheme(),
    bottomAppBarTheme: BottomAppBarTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(),

    scrollbarTheme: ScrollbarThemeData(),


    textTheme: getTextTheme(fontColor: fontColor),
    listTileTheme: getListTitleTheme(fontColor:fontColor),
    checkboxTheme: getCheckBoxTheme(fontColor:fontColor),

    iconTheme: IconThemeData(color: fontColor ?? ColorFont.get().txt, fill: 1),

    buttonTheme: ButtonThemeData(padding: EdgeInsetsGeometry.all(0),minWidth: 0,height: 0),
    textButtonTheme: TextButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),
    iconButtonTheme: IconButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),
    elevatedButtonTheme: ElevatedButtonThemeData(style: globalButtonStyle(fontColor: fontColor)),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: fontColor??ColorFont.get().txt!)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: fontColor??ColorFont.get().txt!)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: fontColor??ColorFont.get().txt!)),
      hoverColor: Colors.transparent,
      // focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppStyle.getMainColor())),
      // labelStyle: TextStyle(color: AppStyle.getMainColor()),
      labelStyle: TextStyle(color:  fontColor??ColorFont.get().txt!),
    ),

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
    // dialogTheme:DialogThemeData(),
    // dividerTheme:DividerThemeData(),
    // drawerTheme:DrawerThemeData(),
    // dropdownMenuTheme:DropdownMenuThemeData(),
    // expansionTileTheme:ExpansionTileThemeData(),

    // menuBarTheme:MenuBarThemeData(),
    // menuTheme:MenuThemeData(),
    // navigationBarTheme:NavigationBarThemeData(),
    // navigationDrawerTheme:NavigationDrawerThemeData(),
    // navigationRailTheme:NavigationRailThemeData(),
    // popupMenuTheme:PopupMenuThemeData(),
    // progressIndicatorTheme:ProgressIndicatorThemeData(),
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
