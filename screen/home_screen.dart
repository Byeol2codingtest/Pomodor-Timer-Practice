import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const timeAmount = 1500 * 30;
  int totalSeconds = 5;
  bool isRunning = false;
  late Timer timer;
  int totalRound = 0;
  int totalGoal = 0;
  int selectedMins = 0;

  List<Widget> selectMins = [
    const Text('10'),
    const Text('15'),
    const Text('20'),
    const Text('25'),
    const Text('30'),
    const Text('35'),
    const Text('40'),
  ];

  // List<int> selectMins = [
  //   10,
  //   15,
  //   20,
  //   25,
  //   30,
  //   35,
  //   40,
  // ];

  final List<bool> _selectedMins = <bool>[
    false,
    false,
    false,
    true,
    false,
    false,
    false,
  ];
  bool vertical = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isRunning = false;
        totalSeconds = timeAmount;
        totalRound = totalRound + 1;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    // print(duration);
    // print(duration.toString().split("."));
    // print(duration.toString().split(".").first);
    // print(duration.toString().split(".").first.substring(2, 7));
    return duration.toString().split(".").first;
  }

  void selectedMinsreturn(String value) {
    setState(() {
      totalSeconds = int.parse(value) * 60;
      timer.cancel();
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 80,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor,
                  Theme.of(context).cardColor,
                  Theme.of(context).scaffoldBackgroundColor,
                ]).createShader(rect);
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ToggleButtons(
                    onPressed: (index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0; i < _selectedMins.length; i++) {
                          _selectedMins[i] = i == index;
                        }
                      });
                      return selectedMinsreturn(selectMins[index]
                          .toString()
                          .split("(")
                          .last
                          .substring(1, 3));
                    },
                    borderRadius: BorderRadius.circular(8),
                    selectedBorderColor: Colors.grey,
                    selectedColor: Theme.of(context).scaffoldBackgroundColor,
                    fillColor: Colors.white,
                    color: Theme.of(context).cardColor,
                    isSelected: _selectedMins,
                    constraints:
                        const BoxConstraints(minHeight: 50, minWidth: 50),
                    children: selectMins,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Center(
              child: IconButton(
                onPressed: isRunning ? onPausePressed : onStartPressed,
                iconSize: 98,
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_fill_outlined,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Round",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "$totalRound",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                              ),
                            ),
                            const Text(
                              "/4",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Flexible(
                    child: Text(
                      "|",
                      style: TextStyle(
                        fontSize: 130,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Goal",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "$totalGoal",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                              ),
                            ),
                            const Text(
                              "/17",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
