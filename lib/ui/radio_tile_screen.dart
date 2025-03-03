import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/radio/radio_bloc.dart';
import 'package:flutter_bloc_learning/bloc/radio/radio_event.dart';
import 'package:flutter_bloc_learning/bloc/radio/radio_state.dart';

class RadioTileScreen extends StatelessWidget {
  const RadioTileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('The build in main');
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Tile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<RadioBloc, RadioState>(
            buildWhen: (previous, current) => previous.value != current.value,
            builder: (context, state) {
              debugPrint('The build inside bloc builder');
              return Column(
                children: [
                  RadioListTile(
                    value: 1,
                    groupValue: state.value,
                    onChanged: (value) {
                      context.read<RadioBloc>().add(ChangeRadio(value: value!));
                    },
                    title: Text('Price High to Low'),
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: state.value,
                    onChanged: (value) {
                      context.read<RadioBloc>().add(ChangeRadio(value: value!));
                    },
                    title: Text('Price Low to High'),
                  ),
                  RadioListTile(
                    value: 3,
                    groupValue: state.value,
                    onChanged: (value) {
                      context.read<RadioBloc>().add(ChangeRadio(value: value!));
                    },
                    title: Text('Sort A to Z'),
                  ),
                ],
              );
            },
          ),
          Divider(
            color: Colors.red,
          ),
          BlocBuilder<RadioBloc, RadioState>(
              buildWhen: (previous, current) =>
                  previous.filter != current.filter,
              builder: (context, state) {
                return Column(
                  children: [
                    RadioListTile(
                      value: Filter.priceHighToLow,
                      groupValue: state.filter,
                      onChanged: (value) {
                        context
                            .read<RadioBloc>()
                            .add(ChangeValue(filter: value!));
                      },
                      title: Text('Price High to Low'),
                    ),
                    RadioListTile(
                      value: Filter.sortAToZ,
                      groupValue: state.filter,
                      onChanged: (value) {
                        context
                            .read<RadioBloc>()
                            .add(ChangeValue(filter: value!));
                      },
                      title: Text('Sort A to Z'),
                    ),
                    RadioListTile(
                      value: Filter.priceLowToHigh,
                      groupValue: state.filter,
                      onChanged: (value) {
                        context
                            .read<RadioBloc>()
                            .add(ChangeValue(filter: value!));
                      },
                      title: Text('Price Low to High'),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}

enum Filter { priceLowToHigh, priceHighToLow, sortAToZ }
