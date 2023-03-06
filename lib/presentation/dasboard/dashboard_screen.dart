import 'package:creator_shop/presentation/profile/profile_screen.dart';
import 'package:creator_shop/utils/widgets/custom_background_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static const path = "DashboardScreen";


  @override
  State<StatefulWidget> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    loop();
    return Scaffold(
      body: CustomBackgroundWidget(
        child: TabBarView(controller: tabController,children: [
          Center(child: ElevatedButton(onPressed: (){

          }, child:const Text("Logout"))),
          Container(
            child: Column(
              children: [
                   Expanded(child: Container()),
                Expanded(child:LayoutBuilder(builder: (context,constraints){
                  return Stack(children: [

                  ]);
                },) ),
                Expanded(child: Container()),


              ],
            ),
          ),
          const ProfileScreen()
        ],
        ),
      ),
      bottomNavigationBar: TabBar(
        tabs: const [
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.create),
          ),
          Tab(
            icon: Icon(Icons.person),
          ),
        ],
        controller: tabController,
      ),
    );
  }

  int loop()
  {int count =0;
    while(count <1000)
      {
        count++;
      }
    return count;
  }
}
