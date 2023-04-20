import 'package:flutter/material.dart';
import '/widgets/appbar.dart';
import '/custom_painter/custom_painter.dart';
import '/custom_painter/object_properties.dart';

class AnimatedBarChart extends StatefulWidget {
  const AnimatedBarChart({super.key});

  @override
  _AnimatedBarChartState createState() => _AnimatedBarChartState();
}

class _AnimatedBarChartState extends State<AnimatedBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List <String> companies = ['Tesla', 'Coca-cola', 'Toyota', 'SpaceX', 'Samsung'];
  List <int> businessShares = [20, 60, 80, 100, 40];
  List <Color> colors = [Colors.black12, Colors.black45, Colors.teal,  Colors.lightBlue, Colors.black26];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'BusinessTrade'),
      body: Center(
        child: Column(children: [
          CustomPaint(
            size: const Size(300, 300),
            painter: BarChartPainter(animation: _animation, data: [
              for (int i = 0; i < companies.length; i++)
                ObjectProperties(value: businessShares[i].ceilToDouble(), color: colors[i]),
            ]),
          ),
          SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < companies.length; i++)
                    RotatedBox(quarterTurns: -1, child: Text(companies[i]))
                ],
              )),
      SizedBox(
          width: 350,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < companies.length; i++)
                OutlinedButton(onPressed: (){
                  setState(() {
                    businessShares[i] += 10;
                  });
                }, child: const Text('+10')),
            ],
          )),
          SizedBox(
              width: 350,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < companies.length; i++)
                    OutlinedButton(onPressed: (){
                      setState(() {
                        businessShares[i] -= 10;
                      });
                    }, child: const Text('-10')),
                ],
              )),
        ]),
      ),
    );
  }
}
