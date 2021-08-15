import 'package:flutter/material.dart';
import 'package:unsplash_app/api_services.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetxh Api"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: FutureBuilder(
                future: APIServices().fetctAPI(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (contex, index) {
                          return ListTile(
                            title: Text('data'),
                          );
                        });
                  }
                })),
      ),
    );
  }
}
