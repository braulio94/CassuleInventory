import 'package:flutter/material.dart';

class BackdropPanel extends StatelessWidget {
  const BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
    this.color,
    this.secondTitle,
    this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget secondTitle;
  final Widget child;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new Material(
      shadowColor: Colors.grey[900],
      color: color,
      elevation: 20.0,
      borderRadius: const BorderRadius.only(
        topLeft: const Radius.circular(16.0),
        topRight: const Radius.circular(16.0),
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            onTap: onTap,
            child: new Container(
              height: 48.0,
              padding: const EdgeInsetsDirectional.only(start: 24.0, end: 24.0),
              alignment: AlignmentDirectional.centerStart,
              child: new DefaultTextStyle(
                style: theme.textTheme.subhead,
                child: Row(
                  children: <Widget>[
                    Tooltip(
                      message: 'Tap to dismiss',
                      child: title,
                    ),
                    Expanded(child: Container(child: icon)),
                    Tooltip(
                      message: 'Tap to dismiss',
                      child: secondTitle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(height: 1.0),
          new Expanded(child: child),
        ],
      ),
    );
  }
}


class BackdropTitle extends AnimatedWidget {
  const BackdropTitle({
    Key key,
    Listenable listenable,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: new Stack(
        children: <Widget>[
          new Opacity(
            opacity: new CurvedAnimation(
              parent: new ReverseAnimation(animation),
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('Select a Category'),
          ),
          new Opacity(
            opacity: new CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('Asset Viewer'),
          ),
        ],
      ),
    );
  }
}