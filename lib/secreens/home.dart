// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:signinfirebase/Modelclass/imgModel.dart';
// import 'package:signinfirebase/riverpod/home_provider.dart';
// import 'package:signinfirebase/riverpod/home_states.dart';

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final homeState = ref.watch(homeProvider.notifier);
//     return Scaffold(
//         appBar: AppBar(),
//         // ignore: sized_box_for_whitespace
//         body: Builder(builder: (context) {
//           if (HomeState is HomeInitialState) {
//             return const HomeLoadingStateStateWidget();
//           } else if (HomeState is HomeLoadingState) {
//             return const HomeLoadingStateStateWidget();
//           } else if (HomeState is HomeLoadedState) {
//             return const HomeLoadedStateStateWidget(
//               listOfPost: [],
//             );
//           } else {
//             return HomeErrorStateStateWidget(errormessage: (errorMessage!));
//           }
//         }));
//   }
// }

// class HomeLoadingStateStateWidget extends ConsumerWidget {
//   const HomeLoadingStateStateWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return const Center(
//         child: CircularProgressIndicator(
//       color: Colors.amber,
//     ));
//   }
// }

// class HomeLoadedStateStateWidget extends ConsumerWidget {
//   const HomeLoadedStateStateWidget({super.key, required this.listOfPost});
//   final List<GetImage> listOfPost;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.read(homeProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('data'),
//       ),
//       body: Center(
//         child: Builder(builder: (context) {
//           GridView.builder(
//           itemCount: listOfPost.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2),
//           itemBuilder: (context, index) {
//             Container(
//               height: 100,
//               width: 100,
//               color: Colors.blueGrey,
//               child: Column(children: [

//               ]),
//             );
//         },);
//           },
//         ),
//       ),
//     );
//   }
// }

// class HomeErrorStateStateWidget extends ConsumerWidget {
//   const HomeErrorStateStateWidget({
//     super.key,
//     required this.errormessage,
//   });
//   final String errormessage;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Text(errormessage);
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:signinfirebase/Modelclass/imgModel.dart';
import 'package:signinfirebase/secreens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api

  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final foodFirestore =
      FirebaseFirestore.instance.collection('food').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          title: const Text("Home Screen"),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 10.00,
          backgroundColor: Colors.greenAccent[400],
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: foodFirestore,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    GetImage getImage =
                        GetImage.fromMap(snapshot.data!.docs[index].data());
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartLoadedStateWidget(
                                // getImage: getImage,
                                img: getImage.img,
                                name: getImage.name,
                                price: getImage.price.toString(),
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Center(
                            child: Card(
                              elevation: 20,
                              child: CircleAvatar(
                                radius: 50,
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  alignment: const Alignment(20, 20),
                                  getImage.img,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              getImage.name,
                              style: const TextStyle(
                                  fontSize: 18,
                                  height: 2,
                                  color: Colors.black,
                                  backgroundColor: Colors.black12,
                                  letterSpacing: 5,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.double,
                                  decorationColor: Colors.black,
                                  decorationThickness: 1.5,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              getImage.price.toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  height: 2,
                                  color: Colors.black,
                                  backgroundColor: Colors.black12,
                                  letterSpacing: 5,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.double,
                                  decorationColor: Colors.black,
                                  decorationThickness: 1.5,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox(
                  height: 10,
                  width: 10,
                );
              }
            }));
  }
}
