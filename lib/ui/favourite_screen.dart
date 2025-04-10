import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_bloc.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_event.dart';
import 'package:flutter_bloc_learning/bloc/favourite/favourite_item_state.dart';
import 'package:flutter_bloc_learning/model/favourite_item_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteItemBloc>().add(const FetchFavouriteItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Screen'),
        centerTitle: true,
        actions: [
          BlocBuilder<FavouriteItemBloc, FavouriteItemState>(
              builder: (context, state) {
            return Visibility(
              visible: state.tempList.isEmpty ? false : true,
              child: IconButton(
                onPressed: () =>
                    context.read<FavouriteItemBloc>().add(const DeleteItem()),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            );
          }),
        ],
      ),
      body: BlocBuilder<FavouriteItemBloc, FavouriteItemState>(
        builder: (context, state) {
          switch (state.loadingState) {
            case LoadingState.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.indigoAccent,
                ),
              );
            case LoadingState.error:
              return const Text('The Error ');
            case LoadingState.completed:
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemCount: state.favouriteItemModel.length,
                itemBuilder: (context, index) {
                  final item = state.favouriteItemModel[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                          //sets the checkbox’s value to true if the item is in the list
                          value: state.tempList.contains(item) ? true : false,
                          onChanged: (value) {
                            if (value!) {
                              context
                                  .read<FavouriteItemBloc>()
                                  .add(SelectItem(favouriteItemModel: item));
                            } else {
                              context
                                  .read<FavouriteItemBloc>()
                                  .add(UnSelectItem(favouriteItemModel: item));
                            }
                          }),
                      title: Text(item.title.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          final favouriteItemModel = FavouriteItemModel(
                              id: item.id,
                              title: item.title,
                              isFavourite: item.isFavourite ? false : true);
                          context.read<FavouriteItemBloc>().add(
                                AddToFavourite(
                                    favouriteItemModel: favouriteItemModel),
                              );
                        },
                        icon: Icon(
                          item.isFavourite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: item.isFavourite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
