import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:majootestcase/bloc/conectivity/connection_cubit.dart';
import 'package:majootestcase/bloc/home_bloc/home_cubit.dart';
import 'package:majootestcase/models/movie_model.dart';
import 'package:majootestcase/services/api.dart';
import 'package:majootestcase/ui/extra/error_screen.dart';
import 'package:majootestcase/ui/home/detail_movie.dart';
import 'package:majootestcase/ui/widget/card_movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController keyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ConnectionCubit()..monitorInternetConnection(),
        child: BlocBuilder<ConnectionCubit, ConnectivityState>(
            builder: (context, state) {
          print("network " + state.networkStatus.toString());
          if (!state.networkStatus) {
            return ErrorScreen();
          } else {
            return Scaffold(
              body: BlocProvider(
                create: (_) => HomeCubit(RestDataSource())..loadMovies(),
                child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                  return SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[100]!,
                                  blurRadius: 5,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: keyController,
                              textCapitalization: TextCapitalization.characters,
                              validator: (value) {},
                              onFieldSubmitted: (String value) {
                                BlocProvider.of<HomeCubit>(context)
                                    .changeStatus();
                                BlocProvider.of<HomeCubit>(context)
                                    .loadMovies(key: value);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 25.h,
                                  color: Colors.grey,
                                ),
                                hintText: "Cari",
                                hintStyle: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 18.sp,
                                    fontFamily: "Nunito"),
                              ),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        state.status == HomeStatus.initial
                            ? _loadingIndicator()
                            : Expanded(
                                child: GridView.builder(
                                  padding:
                                      EdgeInsets.only(left: 8.w, right: 8.w),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.6,
                                          mainAxisSpacing: 4.h,
                                          crossAxisSpacing: 4.w),
                                  itemCount: state.movies.length,
                                  itemBuilder: (context, index) {
                                    return CardMovies(
                                      movie: state.movies[index],
                                      onClick: (MovieModel movie) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailMovie(
                                                    movie: movie,
                                                  )),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  );
                }),
              ),
            );
          }
        }));
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
