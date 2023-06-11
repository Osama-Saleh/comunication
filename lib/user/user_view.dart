// ignore_for_file: avoid_print, prefer_is_empty

// import 'package:communication/chatting/controller/chatting_controller.dart';
import 'package:communication/components/widgets/my_app_bar.dart';
import 'package:communication/user/controller/controller/user_controller.dart';
import 'package:communication/user/widgets/build_item_user.dart';
import 'package:communication/user/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    Provider.of<UserController>(context, listen: false).getAllUser();

    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var providerListenFlase =
        Provider.of<UserController>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(
        title: "Telegram",
        onPressed1: () {
          print("Search");
        },
        icon1: Icons.search,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 20.sp,
            )),
      ),
      //*=============================================
      //* list of users that have Application
      //*=============================================
      body: Provider.of<UserController>(context, listen: true)
                  .countUsers!
                  .length ==
              0
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return BuildItemsUser(
                          userModel: providerListenFlase.countUsers![index]);
                    },
                    itemCount: providerListenFlase.countUsers!.length,
                  ),
                ),
              ],
            ),

      drawer: const MyDrawer(),
    );
  }
}
