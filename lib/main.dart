import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Demo',
      home: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:<Widget>[AnimatedButton(Icons.favorite),
      AnimatedButton(Icons.autorenew),
      AnimatedButton(Icons.close)],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnimatedButton extends StatefulWidget {
  IconData icon;
  AnimatedButton(this.icon);
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this, value: 0);
    controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
      else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.addListener(() {
      print(controller.value);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation smoothAnimation =
    CurvedAnimation(parent: controller, curve: Curves.easeInExpo);
    return GestureDetector(
      onTap: () {
        controller.forward();
      },
      child: Container(
        width: 150,
        height: 150,
        color: Colors.white,
        child: Transform.scale(
          scale: Tween(begin: 1.0, end: 1.5).transform(controller.value),
          child: Icon(
            widget.icon,
            color:Colors.red,
            size: 60,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleVisible() {
    print('Button clicked');
  }
}