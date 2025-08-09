import 'package:flutter/material.dart';
import 'package:flutter3/app-context.dart';
import 'package:flutter3/app-style.dart';
import 'package:flutter3/share/render-by-value-notify.dart';

class Input extends StatefulWidget {
   final String? placeHolder;

   late final Color? bgColor;
   final Widget? prefix;
   final Widget? suffix;
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
  double offsetVertical = 10;
  double offsetBottom = 10;
  var clearButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    offsetBottom = null != widget.placeHolder ? offsetVertical - 3 : offsetVertical;
    _textController.addListener(_inputListen);
  }

  @override
  dispose() {
    _textController.removeListener(_inputListen);
    _textController.dispose();
    super.dispose();
  }

  _inputListen() {
    if (widget.clear && _textController.text.length > 0) {
      clearButton.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: offsetHorizon, right: offsetHorizon, bottom: offsetVertical, top: offsetBottom),
        labelText: widget.animation ? widget.placeHolder : null,
        hintText: widget.animation ? null : widget.placeHolder,
        fillColor: widget.bgColor,
        //  suffix（以及 prefix）位置并不是自由居中的，它是被 InputDecorator 按照基线（baseline）对齐规则放置的，而不是垂直居中放置。
        // 所以当你在 suffix 里放一个 TextButton，它会以文字基线来对齐，而不是以整个输入框高度来对齐，这就导致你看到它会有一点“偏下”或者“偏上”。
        prefixIcon: widget.prefix == null ? null : Padding(padding: EdgeInsets.only(left: 6), child: widget.prefix),

        /// 一直会显示
        // suffix: suffix,
        suffixIcon: Row(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [_clear_button(), ..._suffix()]),

        border: widget.border,
        enabledBorder: widget.border,
        focusedBorder: widget.border,
        disabledBorder: widget.border,

      ),
    );
  }

  _suffix() {
    return [
      widget.suffix == null ? SizedBox.shrink() : SizedBox(width: 16),
      ?widget.suffix == null ? SizedBox.shrink() : Padding(padding: EdgeInsets.only(left: 6), child: widget.suffix),
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
