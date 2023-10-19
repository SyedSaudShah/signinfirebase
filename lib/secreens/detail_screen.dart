import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:signinfirebase/addcart/cart.dart';
import 'package:signinfirebase/riverpod/addcartProvider.dart';
import 'package:signinfirebase/riverpod/addcartState.dart';
import 'package:signinfirebase/secreens/cart_Screen.dart';

class DetailScfreen extends ConsumerWidget {
  const DetailScfreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider.notifier);
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (cartState is CartLoadingState) {
            return const CartLoadingStateWidget();
          } else if (cartState is CartLoadedState) {
            return const Text('Loaded State');
          } else {
            return CartErrorWidget(error: (cartState as CartErrorWidget).error);
          }
        },
      ),
    );
  }
}

class CartLoadingStateWidget extends ConsumerWidget {
  const CartLoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.cyanAccent,
    ));
  }
}

// ignore: must_be_immutable
class CartLoadedStateWidget extends ConsumerStatefulWidget {
  CartLoadedStateWidget(
      {super.key,
      //  required this.getImage,
      required this.img,
      required this.name,
      required this.price});
  // GetImage getImage;
  dynamic img;
  dynamic name;
  dynamic price;

  @override
  ConsumerState<CartLoadedStateWidget> createState() =>
      _CartLoadedStateWidget();
}

class _CartLoadedStateWidget extends ConsumerState<CartLoadedStateWidget> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final cartState = ref.watch(cartProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        flexibleSpace: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        title: const Text("Detail Screen"),
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
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Stack(children: [
                Card(
                  color: Colors.black12,
                  elevation: 40,
                  child: Image.asset(
                    'assets/images/background.png',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 40,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.red,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: CircleAvatar(
                          radius: 30,
                          child: Image.network(
                            widget.img,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              // height: double.infinity,
              // width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  // bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    offset: Offset(0, 9),
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Center(
                  child: Text(
                widget.name,
                style: const TextStyle(
                    letterSpacing: 5,
                    fontStyle: FontStyle.italic,
                    fontSize: 25),
              )),
            ),
            const SizedBox(
              height: 10,
              width: 10,
            ),
            Container(
              // height: double.infinity,
              // width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  // bottomRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white12,
                    offset: Offset(9, 9),
                    blurRadius: 10,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Center(
                  child: Text(
                widget.price.toString(),
                style: const TextStyle(
                    letterSpacing: 5,
                    fontStyle: FontStyle.italic,
                    fontSize: 30),
              )),
            ),
            const SizedBox(
              height: 10,
              width: 10,
            ),
            SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .setDataToFirestore(Cartitem(
                              img: 'img', name: 'name', price: 1, quantity: 1))
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyApp(),
                              )));
                    },
                    child: const Text('add to cart')))
          ],
        ),
      ),
    );
  }
}

class HomeErrorStateStateWidget extends ConsumerWidget {
  const HomeErrorStateStateWidget({
    super.key,
    required this.errormessage,
  });
  final String errormessage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(errormessage);
  }
}

class CartErrorWidget extends ConsumerWidget {
  const CartErrorWidget({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(error);
  }
}

// class DetailScreen extends ConsumerStatefulWidget {
//   const DetailScreen({super.key, required this.item});

//   final String item;

//   @override
//   ConsumerState<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends ConsumerState<DetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     final cartState = ref.watch(cartProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CartScreen(),
//                     ));
//               },
//               icon: const Icon(Icons.shopping_basket_outlined))
//         ],
//         title: const Text("Detail Screen"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Image.network(widget.item),
//             SizedBox(
//               height: 20,
//               width: 20,
//               child: Text(widget.item.toString(),
//                   style: const TextStyle(fontSize: 20)),
//             ),
//             SizedBox(
//               height: 20,
//               width: 20,
//               child: Text(widget.item.toString(),
//                   style: const TextStyle(fontSize: 20)),
//             ),
//             const SizedBox(
//               height: 10,
//               width: 10,
//             ),
//             SizedBox(
//                 child: ElevatedButton(
//                     onPressed: () {
//                       ref.read(cartProvider.notifier);

//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CartScreen(),
//                           ));
//                     },
//                     child: const Text('add to cart')))
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:signinfirebase/secreens/cart_screen.dart';

// class DetailScreen extends StatefulWidget {
//   const DetailScreen({super.key, required this.item});
//   final String item;
//   @override
//   _DetailScreenState createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CartScreen(),
//                     ));
//               },
//               icon: const Icon(Icons.shopping_basket_outlined))
//         ],
//         title: const Text("Detail Screen"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Image.network(widget.item),
//             SizedBox(
//               height: 20,
//               width: 20,
//               child: Text(widget.item.toString(),
//                   style: const TextStyle(fontSize: 20)),
//             ),
//             SizedBox(
//               height: 20,
//               width: 20,
//               child: Text(widget.item.toString(),
//                   style: const TextStyle(fontSize: 20)),
//             ),
//             const SizedBox(
//               height: 10,
//               width: 10,
//             ),
//             SizedBox(
//                 child: ElevatedButton(
//                     onPressed: () {
//                       setDataToFirestore();

//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CartScreen(),
//                           ));
//                     },
//                     child: const Text('add to cart')))
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<void> setDataToFirestore() async {
//   try {
//     // Firestore instance
//     FirebaseFirestore firestore = FirebaseFirestore.instance;

//     // Reference to the Firestore collection and document where you want to set the data
//     DocumentReference documentReference =
//         firestore.collection('your_collection_name').doc('your_document_id');

//     // Data to set (replace 'field_name' with your actual field name)
//     Map<String, dynamic> dataToSet = {
//       'field_name_1': 'cartitem',

//       // Add more fields as needed
//     };

//     // Set the data in Firestore
//     await documentReference.set(dataToSet);

//     print('Data set in Firestore successfully.');
//   } catch (e) {
//     print('Error setting data in Firestore: $e');
//   }
// }
