import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.userName
  });

  final String userName;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            // leading: Icon(Icons.arrow_back_rounded),
            title: Text(
              widget.userName,
              style: const TextStyle(fontSize: 14),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await GoogleSignIn().signOut();
                    FirebaseAuth.instance.signOut();
                    await prefs.setString('authToken', '');
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushReplacementNamed(context, '/login');
                    });
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.exit_to_app),
                  ))
            ]),
        body: Container(),
      ),
    );
  }

  Widget initData() {
    final HttpLink httpLink = HttpLink('');

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );

    const String query = """
        query Content{
          posts{
            id
            title
          }
        }
        """;

    return GraphQLProvider(
      // client: client,
      child: MaterialApp(
          title: 'GraphQL Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar(
                title: const Text(
                  "Home",
                  style: TextStyle(fontSize: 14),
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        await GoogleSignIn().signOut();
                        FirebaseAuth.instance.signOut();
                        await prefs.setString('authToken', '');
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.pushReplacementNamed(context, '/login');
                        });
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(Icons.exit_to_app),
                      ))
                ]),
            body: Query(
                options: QueryOptions(
                    document: gql(query),
                    variables: const <String, dynamic>{
                      "variableName": "value"
                    }),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    print(result);
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (result.data == null) {
                    return const Center(
                      child: Text("No article found!"),
                    );
                  }
                  final posts = result.data!['posts'];
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final title = post['title'];
                      return Container();
                    },
                  );
                }),
          )),
    );
  }
}