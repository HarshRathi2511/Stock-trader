import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:stock_trader/models/http_exceptions.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  DateTime? _expiryDate;
  Timer? _authTimer;

  bool get isAuth {
    if (tokenData != null) {
      return true;
    }
    return false;
  }

  String? get tokenData {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null)
    // when expiry date sometime in the future
    {
      return _token!;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String email, String password, String urlAuth) async {
    try {
      final url = Uri.parse(urlAuth);
      //API_KEY ->settings of firebase-> web api key

      final response = await http.post(url,
          body: json.encode({
            //email,pass,returnToken needed
            'email': email,
            'password': password,
            'returnSecureToken': true, //in the docs
          }));
      // print(json.decode(response.body));
      //returns a map of
//Property Name	Type	Description
// idToken	   string	  A Firebase Auth ID token for the newly created user.
// email	     string	  The email for the newly created user.
// refreshToken	string	A Firebase Auth refresh token for the newly created user.
// expiresIn	  string	The number of seconds in which the ID token expires.
// localId	    string	The uid of the newly created user.

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        //sample error returned from firebase
        //{error: {code: 400, message: EMAIL_EXISTS, errors: [{message: EMAIL_EXISTS, domain: global, reason: invalid}]}}
        throw HttpExceptions(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
      print('sign in / login success');
    } catch (error) {
      print('error in sign up method');
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    //     https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY]
    //use api key here
    return _authenticate(email, password,
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAQ3BfXvEkmBsH_xGCkxhyyEu-cuHVBF30');
  }

  Future<void> login(String email, String password) async {
    //use api key here   AIzaSyAQ3BfXvEkmBsH_xGCkxhyyEu-cuHVBF30
    return _authenticate(email, password,
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAQ3BfXvEkmBsH_xGCkxhyyEu-cuHVBF30');
  }

  Future<void>? logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    //whenever all these properties are set to null the bool
    //isAuth builds again and we go back to the login page
    if (_authTimer != null) {
      _authTimer!
          .cancel(); //if we logout before the timer ends when we press the logout button
    }
    notifyListeners();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpire = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire), () {
      //when the timer is done
      logout();
    }); //A count-down timer that can be configured to fire once or repeatedly.
  }
}
