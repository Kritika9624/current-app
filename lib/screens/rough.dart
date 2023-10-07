//ROUGH CODE



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class  extends StatefulWidget {
//   const Home({
//     super.key, required String userName,
//   });
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     super.initState();
//     // initData();
//   }

  // Widget initData() {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // CollectionReference postsss = firestore.collection('posts');
    // var result = await postsss.doc('0O7m8LSjlha7tdMjun7n').get();


    // final HttpLink httpLink = HttpLink();
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(
//         link: httpLink,
//         cache: GraphQLCache(),
//       ),
//     );
//
//     const String query = """
//         query Content{
//           posts{
//             id
//             title
//           }
//         }
//         """;
//
//     return GraphQLProvider(
//       client: client,
//       child: MaterialApp(
//           title: 'GraphQL Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           home: Scaffold(
//             appBar: AppBar(
//               title: const Text(
//                 "Hygraph Blog",
//               ),
//             ),
//             body: Query(
//                 options: QueryOptions(
//                     document: gql(query),
//                     variables: const <String, dynamic>{"variableName": "value"}),
//                 builder: (result, {fetchMore, refetch}) {
//                   if (result.isLoading) {
//                     print(result);
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   if (result.data == null) {
//                     return const Center(
//                       child: Text("No article found!"),
//                     );
//                   }
//                   final posts = result.data!['posts'];
//                   return ListView.builder(
//                     itemCount: posts.length,
//                     itemBuilder: (context, index) {
//                       final post = posts[index];
//                       final title = post['title'];
//                       return Container();
//                     },
//                   );
//                 }),
//           )),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return initData();
//   }
// }