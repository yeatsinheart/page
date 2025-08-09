import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/share/render-by-value-notify.dart';

class Input extends StatefulWidget {
   final String? placeHolder;

   late final Color? bgColor;
   /// 高度要适中，会撑开输入框
   final Widget? prefix;// 头部区
   final Widget? suffix;// 尾部区
   final InputBorder border;
   /*
  InputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: fontColor ?? ColorFont.get().txt!,width: 0),
    borderRadius: BorderRadius.circular(AppStyle.radius),
  );
  */
   final bool clear;
   final bool animation;

  Input({bool this.animation = false, String? this.placeHolder, Color? color,
    this.border=InputBorder.none,
    Widget? this.prefix, Widget? this.suffix, this.clear = true}) {
    this.bgColor = color ?? (AppContext.isDark ? Colors.black.withValues(alpha: .3) : Colors.white.withValues(alpha: .3));
  }

  @override
  _State createState() => _State();
}

class _State extends State<Input> {
  final _textController = TextEditingController();
  double offsetHorizon = 16;
  double offsetVertical = 12;
  double offsetBottom = 12;
  double rowHeight = 0;
  var clearButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    // 字高 1.2 时相差1.2
    // 实际bottom=设置的bottom−3.6
    offsetBottom = null != widget.placeHolder ? offsetVertical - 1.2 : offsetVertical;
    // offsetBottom =  offsetVertical;
    _textController.addListener(_inputListen);
    rowHeight=AppStyle.fontHeight+2*(12-3.6);
  }

  @override
  dispose() {
    _textController.removeListener(_inputListen);
    _textController.dispose();
    super.dispose();
  }

  _inputListen() {
      clearButton.value = widget.clear && _textController.text.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: offsetHorizon, right: offsetHorizon, bottom: offsetVertical, top: offsetBottom),
        labelText: widget.animation ? widget.placeHolder : null,

        hintText: widget.animation ? null : "${widget.placeHolder}",

        fillColor: widget.bgColor,
        //  suffix（以及 prefix）位置并不是自由居中的，它是被 InputDecorator 按照基线（baseline）对齐规则放置的，而不是垂直居中放置。
        // 所以当你在 suffix 里放一个 TextButton，它会以文字基线来对齐，而不是以整个输入框高度来对齐，这就导致你看到它会有一点“偏下”或者“偏上”。
        prefixIcon: widget.prefix == null ? null : Padding(padding: EdgeInsets.only(left: 6), child: widget.prefix),

        /// 一直会显示
        // suffix: suffix,
        suffixIcon: SizedBox(height: rowHeight,child:Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [_clear_button(), ..._suffix()])),

        border: widget.border,
        enabledBorder: widget.border,
        focusedBorder: widget.border,
        disabledBorder: widget.border,

      ),
    );
  }
  // 高度 = 上下Padding值-3.6 + 字高*字大小
  _suffix() {
    return [
      widget.suffix == null ? SizedBox.shrink() : SizedBox(width: 16),
      ?widget.suffix == null ? SizedBox.shrink() : Padding(padding: EdgeInsets.only(right: 6), child: widget.suffix),
    ];
  }

  _clear_button() {
    return RenderByValueNotify<bool>(
      notifier: clearButton,
      render: (value) {
        return value
            ? TextButton(
                onPressed: () {
                  _textController.clear();
                },
                child: Padding(padding: EdgeInsets.all(6), child: Icon(Icons.clear)),
              )
            : SizedBox.shrink();
      },
    );
  }
}
