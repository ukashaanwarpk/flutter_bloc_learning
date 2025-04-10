import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_bloc.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_event.dart';
import 'package:flutter_bloc_learning/bloc/get_api/get_api_state.dart';
import 'package:flutter_bloc_learning/utils/enum.dart';

class GetApiScreen extends StatefulWidget {
  const GetApiScreen({
    super.key,
  });

  @override
  State<GetApiScreen> createState() => _GetApiScreenState();
}

class _GetApiScreenState extends State<GetApiScreen> {
  @override
  void initState() {
    super.initState();

    context.read<GetApiBloc>().add(FetchItem());
  }

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Api '),
        centerTitle: true,
      ),
      body: BlocBuilder<GetApiBloc, GetApiState>(
        builder: (context, state) {
          switch (state.getStatus) {
            case GetStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case GetStatus.error:
              return Center(
                child: Text(state.message.toString()),
              );
            case GetStatus.success:
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Search',
                      ),
                      onChanged: (value) {
                        context
                            .read<GetApiBloc>()
                            .add(SearchItem(query: value));
                      },
                    ),
                    Expanded(
                      child: state.searchMessage.isNotEmpty
                          ? Center(
                              child: Text(
                              state.searchMessage.toString(),
                            ))
                          : ListView.builder(
                              itemCount: state.tempList.isEmpty
                                  ? state.getItem.length
                                  : state.tempList.length,
                              itemBuilder: (context, index) {
                                final item = state.tempList.isEmpty
                                    ? state.getItem[index]
                                    : state.tempList[index];
                                return ListTile(
                                  title: Text(
                                    item.email.toString(),
                                  ),
                                  subtitle: Text(item.body.toString()),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
