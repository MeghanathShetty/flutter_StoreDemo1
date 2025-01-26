import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/my_apis.dart';
import '../utils/my_constants.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final UserDioController userDioController = Get.put(UserDioController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Expanded(
          child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              if (userDioController.user.value == null) {
                return Center(child: Text("Fetching....."));
              }

              final data = userDioController.user.value!;
              final user = data.results[0];
              // main bordered container
              return Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MyConstants.borderRad),
                  border: Border.all(color: MyConstants.borderColor, width: 1),
                ),
                child: Column(children: [
                  // Image Container
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, // Make the container circular
                    ),
                    child: ClipOval(
                      child: Image.network(
                        user.picture.large,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  // Name
                  Text(
                    '${user.name.title} '
                    '${user.name.first} ${user.name.last}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Phone, Email, Address
                  SizedBox(height: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Phone :', style: TextStyle(color: MyConstants.secondaryColor),),
                        SizedBox(height: 4,),
                        Text('${user.phone} '),
                        SizedBox(height: 10,),
                        Text('Email :', style: TextStyle(color: MyConstants.secondaryColor),),
                        SizedBox(height: 4,),
                        Text('${user.email} '),
                        SizedBox(height: 10,),
                        // address
                        Text('Address :', style: TextStyle(color: MyConstants.secondaryColor),),
                        SizedBox(height: 4,),
                        Text('${user.location.city}'
                            ' ${user.location.state}'
                            ' ${user.location.country}'),
                      ],
                    ),
                ]),
              );
            })
          ],
        ),
      )),
    );
  }
}
