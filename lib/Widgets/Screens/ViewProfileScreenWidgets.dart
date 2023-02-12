import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../general_methods/AppHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../general_methods/TextStyles.dart';
import '../ImageLoader.dart';

class ViewProfileHeader extends StatelessWidget {
  const ViewProfileHeader({
    Key? key,
    required this.imageUrl,
    required this.username,
    required this.name,
    required this.edit,
    required this.onEditProfile,
    required this.email,
    required this.phone,
  }) : super(key: key);
  final String imageUrl;
  final String email;
  final String phone;
  final String name;
  final bool edit;
  final String username;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageLoader(
          imageUrl: imageUrl,
          borderRadius: 14,
          width: 140,
          height: 180,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name != "" ? name : username,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: ()async{
                      await Clipboard.setData(
                        ClipboardData(text: email),
                      );
                      AppHelper.showToastMessage("Email Copied To Clipboard");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppHelper.hexColor("#fff2f0"),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.mail,
                        color: AppHelper.hexColor("#fbb87d"),
                        size: 25,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var url = Uri.parse("tel:$phone");
                      bool canLaunch = phone != "" && await canLaunchUrl(url);
                      if(canLaunch){
                        await launchUrl(url);
                      }else if (phone == ""){
                        AppHelper.showToastMessage("This User Has No Phone !")
                        ;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppHelper.hexColor("#fff2f0"),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.phone,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ),
                  ),
                  edit
                      ? Flexible(
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: AppHelper.hexColor("#ffd800"),
                            ),
                            onPressed: onEditProfile,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ViewProfileBody extends StatelessWidget {
  const ViewProfileBody(
      {Key? key,
      required this.about,
      required this.quizzesNumber,
      required this.email})
      : super(key: key);
  final String about;
  final int quizzesNumber;
  final String email;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          "About",
          style: TextStyles.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          about,
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          width: w,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppHelper.hexColor("#fff2f0"),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.quiz_outlined,
                    size: 45,
                  ),
                  Text(
                    quizzesNumber.toString(),
                    style: TextStyles.listTileTitleStyle,
                  )
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.email,
                      size: 45,
                    ),
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: TextStyles.listTileTitleStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
