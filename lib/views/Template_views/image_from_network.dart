import 'package:final_app/views/Template_views/template_database.dart';
import 'package:flutter/cupertino.dart';

class ImageFromNetwork extends StatefulWidget {
  String imagePath;
  double width;

  ImageFromNetwork({this.imagePath, this.width});

  @override
  _ImageFromNetworkState createState() => _ImageFromNetworkState();
}

class _ImageFromNetworkState extends State<ImageFromNetwork> {
  String imageUrl;

  @override
  void initState() {
    try {
      debugPrint("pathhhhhh" + widget.imagePath);
      TemplateDatabase.getImageUrl(widget.imagePath).then((value) {
        setState(() {
          imageUrl = value;
          debugPrint("imageurl:::::::::::" + imageUrl);
        });
      });
    } catch (e) {
      setState(() {
        imageUrl = null;
      });
      debugPrint(e.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? Image.asset(
            'asset/default.png',
            width: widget.width,
            fit: BoxFit.fill,
          )
        : Image.network(
            imageUrl,
            fit: BoxFit.fill,
          );
  }
}
