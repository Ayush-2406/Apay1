

import 'package:flutter/material.dart';
import 'package:myapp/amplifyconfiguration.dart';
import 'package:myapp/widgets/LoginPage.dart';
import 'package:myapp/widgets/SignUpPage.dart';
import 'package:myapp/widgets/authService.dart';
import 'package:myapp/widgets/verificationPage.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _amplify = Amplify();
    
      final _authService = AuthService();
    
      @override
      void initState() {
      super.initState();
      _configureAmplify();
     _authService.checkAuthStatus();
    }
    
      Widget build(BuildContext context) {
        return MaterialApp(
          title:'Photo Gallery App',
          theme:ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
          
          home : Navigator(
            pages:[
              MaterialPage(child: LoginPage()),
              MaterialPage(child: SignUpPage())
            ],
            onPopPage: (route,result) => route.didPop(result),
          ),
          home: StreamBuilder<AuthState>(
        // 2
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          // 3
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                // 4
                // Show Login Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(child: LoginPage(didProvideCredentials: _authService.loginWithCredentials, shouldShowSignUp: _authService.showSignUp)),
    
                // 5
                // Show Sign Up Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(child: SignUpPage(didProvideCredentials: _authService.signUpWithCredentials,shouldShowLogin: _authService.showLogin)),
                // Show Verification Code Page
                if(snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(child: VerificationPage(
                    didProvideVerificationCode: _authService.verifyCode))
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            // 6
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        }),
        );
      }
    
       void _configureAmplify() async {
         _amplify.addPlugin(authPlugins: [AmplifyAuthCognito()]);
          try {
            await _amplify.configure(amplifyconfig);
            print('Successfully configured Amplify 🎉');
          } catch (e) {
            print('Could not configure Amplify ☠️');
          }
        }
                     
                       
  }
  
  // ignore: non_constant_identifier_names
  Amplify() {
}