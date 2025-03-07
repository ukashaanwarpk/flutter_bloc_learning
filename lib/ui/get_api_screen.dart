import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_bloc.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_event.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_state.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';

class GetApiScreen extends StatefulWidget {
  const GetApiScreen({super.key});

  @override
  State<GetApiScreen> createState() => _GetApiScreenState();
}

class _GetApiScreenState extends State<GetApiScreen> {
  @override
  void initState() {
    super.initState();

    context.read<GetApiBloc>().add(FetchItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Api '),
        centerTitle: true,
      ),
      body: BlocBuilder<GetApiBloc, GetApiState>(
        builder: (context, state) {
          switch (state.getStatus) {
            case GetStatus.loading:
              return Center(child: CircularProgressIndicator());
            case GetStatus.error:
              return Center(
                child: Text(state.message.toString()),
              );
            case GetStatus.success:
              return ListView.builder(
                itemCount: state.getItem.length,
                itemBuilder: (context, index) {
                  final item = state.getItem[index];
                  return ListTile(
                    title: Text(
                      item.email.toString(),
                    ),
                    subtitle: Text(item.body.toString()),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
