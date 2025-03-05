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
    context.read<FavouriteItemBloc>().add(FetchFavouriteItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Screen'),
        centerTitle: true,
      ),
      body: BlocBuilder<FavouriteItemBloc, FavouriteItemState>(
        builder: (context, state) {
          switch (state.loadingState) {
            case LoadingState.loading:
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.indigoAccent,
                ),
              );
            case LoadingState.error:
              return Text('The Error ');
            case LoadingState.completed:
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemCount: state.favouriteItemModel.length,
                itemBuilder: (context, index) {
                  final item = state.favouriteItemModel[index];
                  return Card(
                    child: ListTile(
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
