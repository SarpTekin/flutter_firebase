
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //inputs
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Netcad'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();

            },
          )
        ]

      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled:true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Colors.white, width: 2.0)
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.pink, width: 2.0)
                        ),
                        ),                
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(()=> email = val);

                } ,),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled:true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Colors.white, width: 2.0)
                     ),
                     focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.pink, width: 2.0)
                        ),
                        ),                
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password with more than 6 chars' : null,
                onChanged: (val){
                  setState(()=> password = val);
                  
                }
                 ),

                 SizedBox(height: 20.0),
                 RaisedButton(
                   color: Colors.pink[400],
                   child: Text(
                     'Sign In',
                     style: TextStyle(color: Colors.white),
                   ),
                   onPressed: () async{
                     if(_formkey.currentState.validate()){
                       setState(() {
                         loading = true;
                         
                       });
                       dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                       if(result == null){
                         setState(() {
                           error = 'Could not Sign In with those cedentials';
                           loading = false;
                         });
                       }

                     }
       


                   },
                 ),
                 SizedBox(height: 12.0),
                 Text(
                   error,
                   style: TextStyle(color: Colors.red,fontSize: 14.0),
                 ),                 
            ],),)
      ),
    );
  }
}