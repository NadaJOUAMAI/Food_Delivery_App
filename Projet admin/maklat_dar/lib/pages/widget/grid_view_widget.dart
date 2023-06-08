import 'package:flutter/material.dart';
//orange rail
class GridViewWidget extends StatelessWidget {
  final List<String> urlImages;

  const GridViewWidget({
    required this.urlImages,
    Key? key,
  }) : super(key: key ?? const ValueKey('GridViewWidget'));

  @override
  Widget build(BuildContext context) => GridView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        children: urlImages
            .map((urlImage) => Image.network(urlImage, fit: BoxFit.cover))
            .toList(),
      );
}