import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quantum_it_flutter_assignment/common/utils/snackbar.dart';
import 'package:quantum_it_flutter_assignment/common/widgets/custom_textformfield.dart';
import 'package:quantum_it_flutter_assignment/services/auth_service.dart';
import 'package:quantum_it_flutter_assignment/views/news_list_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TabController _tabController;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  bool areTermsAndCondsAgreed = false;
  String countryDialCode = "+91";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          title: const Text("Social X"),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                "SignIn into your account",
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Form(
                                key: _signInFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Email"),
                                    CustomTextFormField(
                                      hintText: "Enter your email",
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailController,
                                      suffixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 28),
                                    const Text("Password"),
                                    CustomTextFormField(
                                      hintText: "Enter your password",
                                      isObscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: _passwordController,
                                      suffixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Forgot Password ?",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Center(
                                      child: Text(
                                        "Login with",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: InkWell(
                                              onTap: () {},
                                              child: const Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons.google,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: InkWell(
                                              onTap: () {},
                                              child: const Padding(
                                                padding: EdgeInsets.all(12.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons.facebook,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Don't have an account ?",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _tabController.animateTo(
                                                (_tabController.index + 1) % 2);
                                          },
                                          child: const Text(
                                            "Register Now",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 80),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              // Login
                              if (_signInFormKey.currentState!.validate()) {
                                await AuthService.instance.logIn(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                if (AuthService.instance.currentUser != null) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NewsListView(),
                                    ),
                                  );
                                }
                              }
                            },
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              alignment: Alignment.center,
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                "Create an Account",
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Form(
                                key: _signUpFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Name"),
                                    CustomTextFormField(
                                      hintText: "Enter your name",
                                      keyboardType: TextInputType.name,
                                      controller: _nameController,
                                      suffixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 28),
                                    const Text("Email"),
                                    CustomTextFormField(
                                      hintText: "Enter your email",
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _emailController,
                                      suffixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 28),
                                    const Text("Contact no"),
                                    IntlPhoneField(
                                      controller: _phoneController,
                                      initialCountryCode: "IN",
                                      onCountryChanged: (value) {
                                        countryDialCode = value.dialCode;
                                      },
                                    ),
                                    const SizedBox(height: 12),
                                    const Text("Password"),
                                    CustomTextFormField(
                                      hintText: "Enter your password",
                                      isObscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: _passwordController,
                                      suffixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text: "I agree with ",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "terms & conditions",
                                              style: const TextStyle(
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () => launchUrlString(
                                                      "https://www.example.com",
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: areTermsAndCondsAgreed,
                                      onChanged: (value) {
                                        setState(() {
                                          areTermsAndCondsAgreed =
                                              value ?? false;
                                        });
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Already have an account ?",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _tabController.animateTo(
                                                (_tabController.index + 1) % 2);
                                          },
                                          child: const Text(
                                            "Sign In",
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              // Register user
                              if (!areTermsAndCondsAgreed) {
                                showSnackbar(
                                  context,
                                  "Accept the terms and conditions to register",
                                );
                                return;
                              }
                              if (_signUpFormKey.currentState!.validate()) {
                                await AuthService.instance.signUp(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                await AuthService.instance.saveUserInfo(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phoneNum:
                                      "$countryDialCode-${_phoneController.text}",
                                );
                                if (AuthService.instance.currentUser != null) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NewsListView(),
                                    ),
                                  );
                                }
                              }
                            },
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              alignment: Alignment.center,
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
