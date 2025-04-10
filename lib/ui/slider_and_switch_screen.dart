import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/switch/switch_bloc.dart';
import 'package:flutter_bloc_learning/bloc/switch/switch_state.dart';
import 'package:flutter_bloc_learning/bloc/switch/switch_event.dart';

class SliderAndSwitchScreen extends StatefulWidget {
  const SliderAndSwitchScreen({super.key});

  @override
  State<SliderAndSwitchScreen> createState() => _SliderAndSwitchScreenState();
}

class _SliderAndSwitchScreenState extends State<SliderAndSwitchScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('main build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider and Switch'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Notification'),
                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen: (previous, current) =>
                      previous.isEnable != current.isEnable,
                  builder: (context, state) {
                    debugPrint('build inside notification');

                    return CupertinoSwitch(
                      value: state.isEnable,
                      onChanged: (value) {
                        if (value) {
                          context.read<SwitchBloc>().add(const EnableSwitch());
                        } else {
                          context.read<SwitchBloc>().add(const DisableSwitch());
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
                buildWhen: (previous, current) =>
                    previous.sliderValue != current.sliderValue,
                builder: (context, state) {
                  debugPrint('build inside container');
                  return Container(
                    height: 150,
                    width: 300,
                    color: Colors.indigoAccent
                        .withValues(alpha: state.sliderValue),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<SwitchBloc, SwitchState>(
                buildWhen: (previous, current) =>
                    previous.sliderValue != current.sliderValue,
                builder: (context, state) {
                  return Slider(
                    value: state.sliderValue,
                    onChanged: (value) {
                      context.read<SwitchBloc>().add(SliderEvent(value: value));
                    },
                    activeColor: Colors.indigoAccent,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
