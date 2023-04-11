library flutter_datetime_picker;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_datetime_picker/src/datetime_picker_theme.dart';
import 'package:flutter_datetime_picker/src/date_model.dart';
import 'package:flutter_datetime_picker/src/datetime_util.dart';
import 'package:flutter_datetime_picker/src/i18n_model.dart';
import 'package:oniu/base/app_lib.dart';

export 'package:flutter_datetime_picker/src/datetime_picker_theme.dart';
export 'package:flutter_datetime_picker/src/date_model.dart';
export 'package:flutter_datetime_picker/src/i18n_model.dart';

typedef DateChangedCallback(DateTime time);
typedef DateCancelledCallback();
typedef String? StringAtIndexCallBack(int index);

class DatePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static Future<DateTime?> showDatePicker(
    BuildContext context, {
    bool showTitleActions: true,
    List<DateTime>? bookedDateTime,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
    Color? bookedColor,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        bookedDateTime: bookedDateTime,
        bookedColor: bookedColor,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DatePickerModel(
          currentTime: currentTime,
          maxTime: maxTime,
          minTime: minTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static Future<DateTime?> showTimePicker(
    BuildContext context, {
    bool showTitleActions: true,
    List<DateTime>? bookedDateTime,
    bool showSecondsColumn: true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
    Color? bookedColor,
    bool? showMinutes,
    bool? showSeconds,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        bookedDateTime: bookedDateTime,
        bookedColor: bookedColor,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: TimePickerModel(
          showTimeMinutes: showMinutes ?? true,
          showTimeSeconds: showSeconds ?? true,
          currentTime: currentTime,
          locale: locale,
          showSecondsColumn: showSecondsColumn,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet with AM/PM.
  ///
  static Future<DateTime?> showTime12hPicker(
    BuildContext context, {
    bool showTitleActions: true,
    List<DateTime>? bookedDateTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
    Color? bookedColor,
    bool? showMinutes,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        bookedDateTime: bookedDateTime,
        bookedColor: bookedColor,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: Time12hPickerModel(
          showTimeMinutes: showMinutes ?? true,
          currentTime: currentTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static Future<DateTime?> showDateTimePicker(
    BuildContext context, {
    bool showTitleActions: true,
    List<DateTime>? bookedDateTime,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DateTime? currentTime,
    DatePickerTheme? theme,
    Color? bookedColor,
    bool? showMinutes,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        bookedDateTime: bookedDateTime,
        bookedColor: bookedColor,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DateTimePickerModel(
          currentTime: currentTime,
          minTime: minTime,
          showTimeMinutes: showMinutes ?? false,
          maxTime: maxTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date picker bottom sheet witch custom picker model.
  ///
  static Future<DateTime?> showPicker(
    BuildContext context, {
    bool showTitleActions: true,
    List<DateTime>? bookedDateTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    BasePickerModel? pickerModel,
    DatePickerTheme? theme,
    Color? bookedColor,
    bool? showMinutes,
  }) async {
    return await Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        bookedDateTime: bookedDateTime,
        bookedColor: bookedColor,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: pickerModel,
      ),
    );
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.showTitleActions,
    this.bookedDateTime,
    this.bookedColor,
    this.onChanged,
    this.onConfirm,
    this.onCancel,
    DatePickerTheme? theme,
    this.barrierLabel,
    this.locale,
    RouteSettings? settings,
    BasePickerModel? pickerModel,
  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.theme = theme ?? DatePickerTheme(),
        super(settings: settings);

  final bool? showTitleActions;
  final List<DateTime>? bookedDateTime;
  final Color? bookedColor;
  final DateChangedCallback? onChanged;
  final DateChangedCallback? onConfirm;
  final DateCancelledCallback? onCancel;
  final LocaleType? locale;
  final DatePickerTheme theme;
  final BasePickerModel pickerModel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(
        bookedDateTime: bookedDateTime,
        bookedColor: bookedColor,
        onChanged: onChanged,
        locale: locale,
        route: this,
        pickerModel: pickerModel,
      ),
    );
    return InheritedTheme.captureAll(context, bottomSheet);
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent({
    Key? key,
    required this.route,
    required this.pickerModel,
    this.bookedDateTime,
    this.bookedColor,
    this.onChanged,
    this.locale,
  }) : super(key: key);

  final List<DateTime>? bookedDateTime;
  final Color? bookedColor;
  final DateChangedCallback? onChanged;

  final _DatePickerRoute route;

  final LocaleType? locale;

  final BasePickerModel pickerModel;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  late FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
//    print('refreshScrollOffset ${widget.pickerModel.currentRightIndex()}');
    leftScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.route.theme;
    return GestureDetector(
      child: AnimatedBuilder(
        animation: widget.route.animation!,
        builder: (BuildContext context, Widget? child) {
          final double bottomPadding = MediaQuery.of(context).padding.bottom;
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(
                widget.route.animation!.value,
                theme,
                showTitleActions: widget.route.showTitleActions!,
                bottomPadding: bottomPadding,
              ),
              child: GestureDetector(
                child: Material(
                  color: theme.backgroundColor,
                  child: _renderPickerView(theme),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      DateTime? finalTime = widget.pickerModel.finalTime();
      if (widget.bookedDateTime != null &&
          finalTime != null &&
          widget.bookedDateTime!.contains(finalTime)) {
        if (mounted) {
          setState(() {});
        }
      }
      widget.onChanged!(finalTime!);
    }
  }

  Widget _renderPickerView(DatePickerTheme theme) {
    Widget itemView = _renderItemView(theme);
    if (widget.route.showTitleActions == true) {
      return Column(
        children: <Widget>[
          _renderTitleActionsView(theme),
          itemView,
        ],
      );
    }
    return itemView;
  }

  TextStyle getTextStyle(DatePickerTheme theme) {
    DateTime? finalTime = widget.pickerModel.finalTime();
    List<DateTime>? bookedDateTime = widget.bookedDateTime;
    Color? bookedColor = widget.bookedColor;
    TextStyle textStyle = theme.itemStyle;
    if (bookedDateTime != null &&
        finalTime != null &&
        bookedColor != null &&
        bookedDateTime.contains(finalTime)) {
      textStyle = theme.itemStyle.copyWith(color: bookedColor);
    }
    return textStyle;
  }

  Widget getColumnDataText(DatePickerTheme theme, String content, bool isScroll,
      int layoutProportion) {
    TextStyle textStyle = getTextStyle(theme);
    Widget data = Container(
      height: theme.itemHeight,
      alignment: Alignment.center,
      child: Text(
        content,
        style: textStyle,
        textAlign: TextAlign.start,
      ),
    );
    if (isScroll) {
      return data;
    } else {
      return Expanded(
          flex: layoutProportion,
          child: Container(
              padding: EdgeInsets.all(8.0),
              height: theme.containerHeight,
              decoration: BoxDecoration(color: theme.backgroundColor),
              child: data));
    }
  }

  Widget _renderColumnView(
    ValueKey key,
    bool isMinutes,
    DatePickerTheme theme,
    StringAtIndexCallBack stringAtIndexCB,
    ScrollController scrollController,
    int layoutProportion,
    ValueChanged<int> selectedChangedWhenScrolling,
    ValueChanged<int> selectedChangedWhenScrollEnd,
  ) {
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: theme.containerHeight,
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                notification is ScrollEndNotification &&
                notification.metrics is FixedExtentMetrics) {
              final FixedExtentMetrics metrics =
                  notification.metrics as FixedExtentMetrics;
              final int currentItemIndex = metrics.itemIndex;
              selectedChangedWhenScrollEnd(currentItemIndex);
            }
            return false;
          },
          child: CupertinoPicker.builder(
            key: key,
            backgroundColor: theme.backgroundColor,
            scrollController: scrollController as FixedExtentScrollController,
            itemExtent: theme.itemHeight,
            onSelectedItemChanged: (int index) {
              selectedChangedWhenScrolling(index);
            },
            useMagnifier: true,
            itemBuilder: (BuildContext context, int index) {
              final content = stringAtIndexCB(index);
              if (content == null) {
                return null;
              }
              return getColumnDataText(theme, content, true, layoutProportion);
            },
          ),
        ),
      ),
    );
  }

  Widget _renderItemView(DatePickerTheme theme) {
    TextStyle style = getTextStyle(theme);

    return Container(
      color: theme.backgroundColor,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: widget.pickerModel.layoutProportions()[0] > 0
                  ? _renderColumnView(
                      ValueKey(widget.pickerModel.currentLeftIndex()),
                      false,
                      theme,
                      widget.pickerModel.leftStringAtIndex,
                      leftScrollCtrl,
                      widget.pickerModel.layoutProportions()[0], (index) {
                      widget.pickerModel.setLeftIndex(index);
                    }, (index) {
                      setState(() {
                        refreshScrollOffset();
                        _notifyDateChanged();
                      });
                    })
                  : null,
            ), // Date Container
            Text(
              widget.pickerModel.leftDivider(),
              style: style,
            ),
            Container(
              child: widget.pickerModel.minutesLocation() == middle &&
                      !widget.pickerModel.showMinutes()
                  ? widget.pickerModel.layoutProportions()[1] > 0
                      ? getColumnDataText(theme, '00', false,
                          widget.pickerModel.layoutProportions()[1])
                      : null
                  : widget.pickerModel.layoutProportions()[1] > 0
                      ? _renderColumnView(
                          ValueKey(widget.pickerModel.currentLeftIndex()),
                          false,
                          theme,
                          widget.pickerModel.middleStringAtIndex,
                          middleScrollCtrl,
                          widget.pickerModel.layoutProportions()[1], (index) {
                          widget.pickerModel.setMiddleIndex(index);
                        }, (index) {
                          setState(() {
                            refreshScrollOffset();
                            _notifyDateChanged();
                          });
                        })
                      : null,
            ), // hour container
            Text(
              widget.pickerModel.rightDivider(),
              style: style,
            ),
            Container(
              child: widget.pickerModel.minutesLocation() == right &&
                      !widget.pickerModel.showMinutes()
                  ? widget.pickerModel.layoutProportions()[2] > 0
                      ? getColumnDataText(theme, '00', false,
                          widget.pickerModel.layoutProportions()[2])
                      : null
                  : widget.pickerModel.secondsLocation() == right &&
                          !widget.pickerModel.showSeconds()
                      ? widget.pickerModel.layoutProportions()[2] > 0
                          ? getColumnDataText(theme, '00', false,
                              widget.pickerModel.layoutProportions()[2])
                          : null
                      : widget.pickerModel.layoutProportions()[2] > 0
                          ? _renderColumnView(
                              ValueKey(widget.pickerModel.currentMiddleIndex() *
                                      100 +
                                  widget.pickerModel.currentLeftIndex()),
                              false,
                              theme,
                              widget.pickerModel.rightStringAtIndex,
                              rightScrollCtrl,
                              widget.pickerModel.layoutProportions()[2],
                              (index) {
                              widget.pickerModel.setRightIndex(index);
                            }, (index) {
                              setState(() {
                                refreshScrollOffset();
                                _notifyDateChanged();
                              });
                            })
                          : null,
            ), // minute container
          ],
        ),
      ),
    );
  }

  // Title View
  Widget _renderTitleActionsView(DatePickerTheme theme) {
    final done = _localeDone();
    final cancel = _localeCancel();

    return Container(
      height: theme.titleHeight,
      decoration: BoxDecoration(
        color: theme.headerColor ?? theme.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: const EdgeInsetsDirectional.only(start: 16, top: 0),
              child: Text(
                '$cancel',
                style: theme.cancelStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
                if (widget.route.onCancel != null) {
                  widget.route.onCancel!();
                }
              },
            ),
          ),
          Container(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsetsDirectional.only(end: 16, top: 0),
              child: Text(
                '$done',
                style: theme.doneStyle,
              ),
              onPressed: () {
                DateTime nowTime = DateTime.now();

                DateTime? finalTime = widget.pickerModel.finalTime();

                if (finalTime!.compareTo(nowTime) < 0) {
                  lottieController.errorMessage('Cannot choose past time');
                  return;
                }

                List<DateTime>? bookedDateTime = widget.bookedDateTime;
                if (bookedDateTime != null &&
                    finalTime != null &&
                    bookedDateTime.contains(finalTime)) {
                  return;
                }
                Navigator.pop(context, finalTime);
                if (widget.route.onConfirm != null) {
                  widget.route.onConfirm!(finalTime);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale)['done'] as String;
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale)['cancel'] as String;
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(
    this.progress,
    this.theme, {
    this.itemCount,
    this.showTitleActions,
    this.bottomPadding = 0,
  });

  final double progress;
  final int? itemCount;
  final bool? showTitleActions;
  final DatePickerTheme theme;
  final double bottomPadding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight;
    if (showTitleActions == true) {
      maxHeight += theme.titleHeight;
    }

    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight + bottomPadding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
