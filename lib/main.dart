
import 'package:flutter/material.dart';
import 'package:inventory_app/database/data.dart';
import 'package:inventory_app/database/database.dart';
import 'package:inventory_app/model/category.dart';
import 'package:inventory_app/pages/home_page.dart';
import 'dart:math' as math;

import 'package:inventory_app/widgets/backdrop.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cassule Inventory',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  final GlobalKey _globalKey = new GlobalKey(debugLabel: 'Main');
  ProductDatabase database;
  AnimationController _controller;
  Category _category = allCategories[0];

  @override
  void initState() {
    super.initState();
    database = ProductDatabase();
    database.initDB();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 0.0,
      vsync: this,
    );
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _globalKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    database.closeDb();
    super.dispose();
  }

  void _changeCategory(Category category) {
    setState(() {
      _category = category;
      _toggleBackdropPanelVisibility();
    });
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    double width = screenWidth / 4;
    final Animation<RelativeRect> panelAnimation = new RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        0.0,
        panelTop - MediaQuery.of(context).padding.bottom,
        0.0,
        panelTop - panelSize.height,
      ),
      end: RelativeRect.fromLTRB(0.0, 350.0, 0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    final List<Widget> backdropItems = allCategories.map<Widget>((Category category) {
      final bool selected = category == _category;
      return new Material(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        ),
        color: selected ? Colors.white.withOpacity(0.25) : Colors.transparent,
        child: ListTile(
          title: Text(category.title),
          selected: selected,
          onTap: () {
            _changeCategory(category);
          },
        ),
      );
    }).toList();

    return Container(
      key: _globalKey,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: HomePage(database: database, productDetailsList: _category.list),
            behavior: HitTestBehavior.opaque,
            onTap: (){
              if(_backdropPanelVisible){
                _toggleBackdropPanelVisibility();
              }
            },
          ),
          PositionedTransition(
            rect: panelAnimation,
            child: BackdropPanel(
              color: Colors.white,
              onTap: _toggleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              icon: Icon(_backdropPanelVisible ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up, size: 30.0),
              title: Text(_category.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              secondTitle:  Text(dateMonth(DateTime.now().month).toUpperCase(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: width,
                child: Column(
                  children: backdropItems,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: _buildStack,
      );
  }
}
