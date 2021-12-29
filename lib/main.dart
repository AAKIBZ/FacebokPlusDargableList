import 'package:demoapppresentation/models/logInDetailsModel.dart';
import 'package:demoapppresentation/screens/dragable_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = false;
  AccessToken? accessToken;
  LogInDetailsModel? _currentUserModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook Login'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    LogInDetailsModel? user = _currentUserModel;

    if (user != null) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: user.pictureDetailsModel!.width! / 6,
                backgroundImage: NetworkImage(user.pictureDetailsModel!.url!),
              ),
              title: Text(user.name!),
              subtitle: Text(user.email!),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Signed In Successfully',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(onPressed: _logOut, child: const Text('Log Out')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListDataScreen()));
                },
                child: const Text('To Other Screen'))
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'You Are Not Signed In',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: signIn, child: const Text('Log In')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListDataScreen()));
                },
                child: const Text('Navigate')),
          ],
        ),
      );
    }
  }

  Future<void> signIn() async {
    final LoginResult result = await FacebookAuth.i.login();
    switch (result.status) {
      case LoginStatus.success:
        const sandbar = SnackBar(
            content: Text(
          'Success',
          style: TextStyle(fontSize: 20, color: Colors.green),
        ));
        const SnackBar(
          content: sandbar,
        );
        ScaffoldMessenger.of(context).showSnackBar(sandbar);

        accessToken = result.accessToken;
        final data = await FacebookAuth.i.getUserData();
        LogInDetailsModel logInDetailsModel = LogInDetailsModel.fromJson(data);

        setState(() {
          _currentUserModel = logInDetailsModel;
        });
        break;
      case LoginStatus.cancelled:
        const sandbar = SnackBar(
            content: Text(
          'User Cancelled the Login Process',
          style: TextStyle(fontSize: 20, color: Colors.green),
        ));
        const SnackBar(
          content: sandbar,
        );
        ScaffoldMessenger.of(context).showSnackBar(sandbar);
        break;
      case LoginStatus.failed:
        const sandbar = SnackBar(
            content: Text(
          'failed due to unknown reasons',
          style: TextStyle(fontSize: 20, color: Colors.green),
        ));
        const SnackBar(
          content: sandbar,
        );
        ScaffoldMessenger.of(context).showSnackBar(sandbar);
        break;
      case LoginStatus.operationInProgress:
        const sandbar = SnackBar(
            content: Text(
          'In Progress',
          style: TextStyle(fontSize: 20, color: Colors.green),
        ));
        const SnackBar(
          content: sandbar,
        );
        ScaffoldMessenger.of(context).showSnackBar(sandbar);
        break;
    }
  }

  void _logOut() async {
    const sandbar = SnackBar(
        content: Text(
      'Logged Out',
      style: TextStyle(fontSize: 20, color: Colors.green),
    ));
    const SnackBar(
      content: sandbar,
    );
    ScaffoldMessenger.of(context).showSnackBar(sandbar);
    await FacebookAuth.i.logOut();
    setState(() {
      _currentUserModel = null;
      accessToken = null;
    });
  }
}
