import 'package:flutter/material.dart';
import 'package:retrofit_example/api_service.dart';
import 'package:dio/dio.dart';
import 'package:retrofit_example/post_model.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return MaterialApp(
     theme: ThemeData(
       primarySwatch: Colors.blueGrey
     ),
     home: MyHomePage(),
   );
  }
}
class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomePageState();
  }
}
class MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: const Text("Retrofit Example"),
       centerTitle: true,
     ),
     body: _body(),
   );
  }
  FutureBuilder _body(){
    final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
      future:  apiService.getPosts(),
        builder: (context, snapshot) {
        if(snapshot.connectionState ==  ConnectionState.done)
        {
          final List<PostModel> posts = snapshot.data!;
          return _posts(posts);
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        });
  }

  Widget _posts(List<PostModel> posts){
    return ListView.builder(
      itemCount: posts.length,
        itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black38 ,width: 1),
          ),
          child: Column(
            children: [
              Text(posts[index].title ,style: const TextStyle(
                fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),
              Text(posts[index].title),
            ],
          ),
        );
    });
  }
}