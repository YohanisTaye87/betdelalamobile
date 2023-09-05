import 'package:betdelalamobile/acounts/login.dart';
import 'package:betdelalamobile/agent/agent_registration.dart';
import 'package:betdelalamobile/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widget/user_product.dart';

class UserProfile extends StatefulWidget {
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context);
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Yohanis Taye'),
            onTap: () {
              //  Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Delala'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent_sharp),
            title: const Text('Become an agent'),
            onTap: () {
              print(auth.pid);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AgentRegistration(
                  userPublicId: auth.pid,
                ),
              ));
              // Navigator.of(context).push((MaterialPageRoute(
              //     builder: ((context) => AgentRegistration()))));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('LogOut'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed((LoginScreen.routeName));
              // Navigator.of(context)
              //     .pushReplacementNamed(AgentRegistration(userPublicId: userPublicId, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, userPassword: userPassword, email: email, street: street, city: 'bahir', addressId: addressId));
            },
          ),
        ],
      ),
    ));
  }
}
