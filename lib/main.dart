import 'package:flutter/material.dart';
import 'package:news_updates/constant/constant.dart';
import 'package:news_updates/models/article_model.dart';
import 'package:news_updates/network/network_enums.dart';
import 'package:news_updates/network/network_helper.dart';
import 'package:news_updates/network/network_service.dart';
import 'package:news_updates/widget/news_headline.dart';

import 'network/query_param.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("NewsUpdates"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              //final json = snapshot.data;

              final List<Article> articles = snapshot.data as List<Article>;

              return ListView.builder(itemBuilder: (context, index) {
                return NewsHeadline(article: articles[index]);
              },
                itemCount: articles.length,);
            }
            else if (snapshot.hasError) {
              return Text("SomeThing went Wrong${snapshot.error}");
            }
            else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        )
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
 // get data() for the future stream/ body
  Future<List<Article>?> getData() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      url: Constant.apiUrl,
      queryParam: QP.apiQP(
          apiKey: Constant.apiKey, country: Constant.apiCountry),
    );
    print(response?.statusCode);

    return await NetworkHelper.filterResponse(
        callBack: _listOfArticleFromJson ,
        response: response,
        onFailureCallBackWithMessage:(errorType, msg) {
        print("Error type- $errorType ,Message -$msg");
        return null;
        },parameterName: CallBackPararmeterName.articles);


  }

  List<Article>_listOfArticleFromJson(json) => (json as List)
      .map((e) => Article.fromJson(e as Map<String, dynamic>))
      .toList();
}
