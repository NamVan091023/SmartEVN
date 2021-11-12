import 'package:flutter/material.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/screen/edit_profile/edit_profile_screen.dart';

class ProfilePic extends StatelessWidget {
  final Data user;

  const ProfilePic({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: user.avatar == null
                ? AssetImage("assets/images/profile_image.png")
                : NetworkImage(
                    user.avatar,
                  ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 30,
              width: 30,
              child: FlatButton(
                padding: EdgeInsets.all(2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                            user: user,
                          )));
                },
                child: new Icon(
                  Icons.edit_outlined,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class _StatePick extends State<ProfilePic> {
//   File _image;
//   Future _openCamera(BuildContext context) async {
//     PickedFile picture =
//     await ImagePicker().getImage(source: ImageSource.camera);
//     setState(() {
//       if (picture != null) _image = File(picture.path);
//     });
//   }
