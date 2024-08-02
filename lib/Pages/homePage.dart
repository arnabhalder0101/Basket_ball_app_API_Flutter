import 'dart:convert';

import 'package:basket_ball_api_app/Components/app_drawer.dart';
import 'package:basket_ball_api_app/Models/Teams.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  List<Teams> allTeams = [];
  HomePage({super.key});

  Future getTeams() async {
    String url = "https://api.balldontlie.io/v1/teams";
    String api_key = "7cf8c89b-a10e-463a-b3ef-35035e3c988a";

    var response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": api_key},
    );
    // print(response.body);
    // print(jsonDecode(response.body)['data'][23]);
    var data = jsonDecode(response.body)['data'];

    for (var item in data) {
      Teams team = Teams(
          city: item["city"],
          full_name: item["full_name"],
          abbreviation: item['abbreviation'],
          division: item['division']);
      // print(
      //     "ID: ${item['id']} - Name: ${item['full_name']} - Abbreviation: ${item['abbreviation']}");
      allTeams.add(team);
    }
    print(allTeams.length);
  }

  @override
  Widget build(BuildContext context) {
    // var myteams = getTeams();
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text("T E A M S"),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 29,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                // future - > for which we're waiting that method
                future: getTeams(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // return listview builder --
                    return ListView.builder(
                      itemCount: allTeams.length,
                      itemBuilder: (context, index) {
                        Teams individualTeams = allTeams[index];
                        // List<String> firstName =
                        //     individualTeams.full_name.split(" ");

                        return Padding(
                          padding:
                              EdgeInsets.only(left: 18, right: 18, bottom: 11),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: Colors.orange[200],
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(firstName[0]),
                                Text(
                                  individualTeams.full_name,
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                Text(individualTeams.abbreviation),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  // else is much needed --
                  else {
                    return Text("Something goes wrong!");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
