import 'package:dattings/datings/Home/home.dart';
import 'package:dattings/datings/Messages/messages_page.dart';
import 'package:dattings/datings/More_add/add_more_screen.dart';
import 'package:dattings/datings/News/Item_news.dart';
import 'package:dattings/datings/Profile/profile_page.dart';
import 'package:flutter/material.dart';

class HomeAppDatings extends StatefulWidget {
  const HomeAppDatings({Key? key}) : super(key: key);

  @override
  State<HomeAppDatings> createState() => _HomeAppDatingsState();
}

class _HomeAppDatingsState extends State<HomeAppDatings> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(),
    const ItemNews(
      phone: '',
    ),
    const MessagesPage(),
    const ProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentSreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageStorage(
            bucket: bucket,
            child: currentSreen,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MoreScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentSreen = const HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/Home.png',
                          color: currentTab == 0 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentTab == 0
                                ? Colors.green
                                : const Color(0xffC6C6C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentSreen = const ItemNews(
                          phone: '',
                        );
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/Budget.png',
                          color: currentTab == 1 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'News',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentTab == 1
                                ? Colors.green
                                : const Color(0xffC6C6C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentSreen = const MessagesPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/Budget.png',
                          color: currentTab == 3 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'Messeges',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentTab == 3
                                ? Colors.green
                                : const Color(0xffC6C6C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 90,
                    onPressed: () {
                      setState(() {
                        currentSreen = const ProfilePage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/Profile.png',
                          color: currentTab == 2 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 10,
                            color: currentTab == 2
                                ? Colors.green
                                : const Color(0xffC6C6C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
