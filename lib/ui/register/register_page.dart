import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:majootestcase/bloc/register/sign_up_cubit.dart';
import 'package:majootestcase/common/widget/custom_button.dart';
import 'package:majootestcase/models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController =
      TextEditingController();
  TextEditingController _passwordController =
      TextEditingController();
  TextEditingController _usernameController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SignUpCubit(),
        child:
            BlocConsumer<SignUpCubit, SignUpState>(listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            var snackBar = const SnackBar(
              content: Text("Register Berhasil"),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            _emailController.clear();
            _passwordController.clear();
            _usernameController.clear();
          }
        }, builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding:  EdgeInsets.all(8.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                'Selamat Datang',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  // color: colorBlue,
                ),
              ),
              Text(
                'Silahkan register terlebih dahulu',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),_form(), BtnSignUp()],
              ),
            ),
          );
        }),
      ),
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
           SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _usernameController,
            textCapitalization: TextCapitalization.sentences,
            validator: (value) {
              if (value!.isEmpty) {
                return "Form tidak boleh kosong, mohon cek kembali data yang anda inputkan";
              }
            },
            onSaved: (value) {},
            decoration: InputDecoration(
                labelText: "User Name",
                labelStyle: TextStyle(color: Colors.black, fontSize: 18.sp),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget BtnSignUp() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomButton(
              text: 'Register',
              clicked: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpCubit>().register(User(
                    email: _emailController.text,
                    password: _passwordController.text,
                    userName: _usernameController.text));
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
