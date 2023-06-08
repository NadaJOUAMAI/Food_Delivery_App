
import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  final List<String> urlImages;

  const GridViewWidget({
    required this.urlImages,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GridView(  //un conteneur de grille.
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(4),  //un espacement intérieur de 4 pixels autour de la grille.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,   //nbr de colonnes
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        children: urlImages
            .map((urlImage) => Image.network(urlImage, fit: BoxFit.cover))
            .toList(), //Convertit le résultat du map en une liste de widgets.
      );
}
