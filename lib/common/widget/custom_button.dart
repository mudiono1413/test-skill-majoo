import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final bool isLoad;
  final String text;
  final Widget? route;
  final Color colors;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final Function() clicked;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.clicked,
      this.route,
      required this.colors,
      required this.isLoad,
      this.textStyle,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => HomeScreen(),
          //     ));
          clicked();
        },
        style: ElevatedButton.styleFrom(
          primary: colors,
          onPrimary: Colors.white,
          elevation: 5,
          fixedSize: Size(width !=null ? width!.w : MediaQuery.of(context).size.width, height != null ? height!.h :
              MediaQuery.of(context).size.height / 16),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        child: isLoad
            ? const CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(text,
                style: textStyle ??
                    TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Nunito",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0.sp),
                textAlign: TextAlign.center));
  }
}
