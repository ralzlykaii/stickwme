import 'package:flutter/material.dart';
import 'package:stickwmeapp/widgets/custom_scaffold.dart';
import 'package:stickwmeapp/widgets/welcomescreenbuttons.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150.0), //adjust space between 
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Welcome\n',
                                style: TextStyle(
                                  fontSize: 150.0,
                                  fontFamily: 'BetterTogether',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        WelcomeButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}