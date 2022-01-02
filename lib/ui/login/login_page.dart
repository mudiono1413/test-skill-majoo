import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:majootestcase/bloc/login_bloc/login_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/models/user.dart';
import 'package:formz/formz.dart';
import 'package:majootestcase/ui/home/home_page.dart';
import 'package:majootestcase/ui/register/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isObscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          var snackBar = SnackBar(
            content: Text(state.exceptionError),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state.status.isSubmissionSuccess) {
          var snackBar = const SnackBar(
            content: Text("Login Berhasil"),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      }, builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(8.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Selamat Datang',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  // color: colorBlue,
                ),
              ),
              Text(
                'Silahkan login terlebih dahulu',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              _form(),
              SizedBox(
                height: 10.h,
              ),
              Login(),
              SizedBox(
                height: 10.h,
              ),
              _register(),
            ],
          ),
        );
      }),
    );
  }

  Widget _form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (value!.isEmpty) {
                return 'Form tidak boleh kosong, mohon cek kembali data yang anda inputkan';
              } else {
                return pattern.hasMatch(value)
                    ? null
                    : 'Masukkan e-mail yang valid';
              }
            },
            onSaved: (value) {},
            decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _passwordController,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value!.isEmpty) {
                return "Form tidak boleh kosong, mohon cek kembali data yang anda inputkan";
              }
            },
            onSaved: (value) {},
            decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _register() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        },
        child: RichText(
          text: TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(color: Colors.black45),
              children: [
                TextSpan(
                  text: 'Daftar',
                ),
              ]),
        ),
      ),
    );
  }

  Widget Login() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomButton(
              text: 'Login',
              clicked: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginCubit>().loginUser(User(
                      email: _emailController.text,
                      password: _passwordController.text));
                }
              },
              height: 40.h,
              colors: Theme.of(context).primaryColor,
              isLoad: state.status.isSubmissionInProgress,
            ));
      },
    );
  }
}
