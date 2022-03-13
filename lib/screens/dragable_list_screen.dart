import 'dart:developer';

import 'package:demoapppresentation/models/users.dart';
import 'package:demoapppresentation/services/service.dart';
import 'package:draggable_flutter_list/draggable_flutter_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class ListDataScreen extends StatefulWidget {
  const ListDataScreen({Key? key}) : super(key: key);

  @override
  _ListDataScreenState createState() => _ListDataScreenState();
}

class _ListDataScreenState extends State<ListDataScreen> {
  List<Users> items = [];
  bool isLoading = false;

  ///this function fetches the users lat long and user details from the api
  void fetchUsersLatLong() {
    isLoading = true;
    Services.fetchUsersLatLong().then((users) => {items = users,setState((){})});
    isLoading = false;
  }

  @override
  void initState() {
    fetchUsersLatLong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLoading ? 'Loading....' : 'Users'),
      ),
      body: FutureBuilder(
        future: Services.fetchUsersLatLong(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DragAndDropList(
              items.length,
              itemBuilder: (BuildContext context, index) {
                return SizedBox(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 8, left: 16, right: 16, bottom: 4),
                    width: double.infinity,
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name =' + items[index].name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 05,
                          ),
                          Text('Latitude = ' + items[index].address.geo.lat),
                          const SizedBox(
                            height: 03,
                          ),
                          Text('Longitude = ' + items[index].address.geo.lng),
                          const SizedBox(
                            height: 03,
                          ),
                          const Divider(
                            thickness: 1.0,
                            height: 3.0,
                            color: Colors.grey,
                          ),
                        ]),
                  ),
                );
              },
              onDragFinish: (before, after) {
                print('on drag finish $before $after');
                Users data = items[before];
                items.removeAt(before);
                items.insert(after, data);
              },
              canDrag: (index) {
                print('can drag $index');
                return index != 3; //disable drag for index 3
              },
              canBeDraggedTo: (one, two) => true,
              dragElevation: 8.0,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
