import 'package:betdelalamobile/helper/utility.dart';
import 'package:flutter/material.dart';
import 'package:more_loading_gif/more_loading_gif.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../widget_functions/style.dart';

class PostRegistrationDialogue extends StatefulWidget {
  final String title;
  const PostRegistrationDialogue({Key? key, required this.title})
      : super(key: key);

  @override
  State<PostRegistrationDialogue> createState() => _PostRegistrationDialogue();
}

class _PostRegistrationDialogue extends State<PostRegistrationDialogue> {
  Utility ut = Utility();

  @override
  void initState() {
    super.initState();
    // list = Provider.of<Fetch>(context, listen: false)
    //     .userRegisteredRestaurants(context);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.check, size: 35.0),
              ),
              const SizedBox(
                height: 20,
              ),
              TitleFont(
                // maxLines: 2,
                overflow: TextOverflow.ellipsis,
                align: TextAlign.justify,
                text: widget.title,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(
                height: 5,
              ),
              const TitleFont(
                // maxLines: 2,
                overflow: TextOverflow.ellipsis,
                align: TextAlign.justify,
                text: 'successfully registered!',
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: DescriptionFont(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: 'To get your restaurant approved Please call',
                  size: deviceWidth > 380 ? 13 : 12,
                  align: TextAlign.right,
                ),
              ),
              TextButton(
                  onPressed: () {
                    ut.callNow('+251947707075');
                  },
                  child: const DescriptionFont(
                    text: '+251947707075',
                    size: 17,
                    color: AppColors.secondary,
                  )),

              Column(
                children: [
                  const DescriptionFont(text: 'or'),
                  TextButton(
                      onPressed: () {
                        // callnow('+251947707075', context);
                      },
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pop();
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) =>
                          //         // UserRestaurantsList(
                          //         //     // data: snapshot.data,
                          //         // )
                          //             )

                          //             );
                        },
                        child: const DescriptionFont(
                          text: 'Go to your restaurants list',
                          size: 17,
                          color: Colors.blue,
                        ),
                      )),
                ],
              ),
              // else
              // SizedBox(
              //   height: 65,
              //   child: MoreLoadingGif(
              //     type: MoreLoadingGifType.ellipsis,
              //     size: 100,
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              // FractionallySizedBox(
              //   widthFactor: 0.8,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //           backgroundColor: AppColors.primary),
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //       child: Info2Font(
              //         text: 'Close',
              //         size: 17,
              //         color: AppColors.white,
              //       )),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
