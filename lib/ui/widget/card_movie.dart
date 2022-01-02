import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:majootestcase/models/movie_model.dart';

class CardMovies extends StatelessWidget {
  final MovieModel movie;
  final Function(MovieModel) onClick;
  const CardMovies({Key? key, required this.movie,required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick(movie);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2.w,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: Image.network(
                movie.i!.imageUrl ??"" ,
                height: 210.h,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 4.w, right: 4.w),
              child: Text(
                movie.l ??"" ,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 20.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
