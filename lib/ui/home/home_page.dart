import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico_ibhavan/models/user_model.dart';
import 'package:medico_ibhavan/utils/auth.dart';
import 'package:medico_ibhavan/utils/cloud_firestore.dart';
import 'package:medico_ibhavan/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final servicesList = ['Service 1', 'Service 2', 'Service 3'];

  final User? currentUser = Auth().currentUser;
  UserModel? user;

  Future<void> fetchUserData() async {
    final snapshot = await FireStore().getUserData(currentUser!.email!);
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      user = UserModel.fromJson(data);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(bgcolor),
        appBar: AppBar(
          backgroundColor: const Color(appBarBlack),
          leading: const Icon(
            Icons.home,
            color: Color(whiteColor),
            size: 27,
          ),
          title: Text(
            'Hello ${user?.firstName ?? ''}!',
            style: const TextStyle(
              color: Color(whiteColor),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            //Notification Icon
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(slate),
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.notifications, color: Color(primary))),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(appBarBlack),
                    borderRadius: BorderRadius.circular(12),
                  ), // BoxDecoration I
                  padding: const EdgeInsets.all(12),
                  //Search
                  child: const Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ), // Icon
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0), //hozizantalissue
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: const Color(primaryLight),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(
                            "https://cdn-icons-png.flaticon.com/128/1540/1540809.png"),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "How do You Feel? Let us Know!!!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Fill out our medical form to get a friendly service from a qualified Doctor",
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: const Color(appBarBlack),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                  child: Text(
                                "Get Started",
                                style: TextStyle(
                                    color: Color(whiteColor),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Explore Services",
                          style: TextStyle(fontSize: 17),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("See All",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color(primaryDark),
                                  fontWeight: FontWeight.bold,
                                  decorationColor: Color(primaryDark),
                                  decorationThickness: 2,
                                ))),
                      ]),
                ),
                GridView.builder(
                    itemCount: 3, //imagesList.length,
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 6,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 10,
                    ), // Sliver GridDelegateWith FixedCrossAxis Count
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(primaryLight),
                          // image: DecorationImage(
                          //     image: NetworkImage(imagesList[index]),
                          //     fit: BoxFit.cover)
                        ),
                        child: Text(
                          servicesList[index],
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
