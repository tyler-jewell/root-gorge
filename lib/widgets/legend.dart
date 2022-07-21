import 'package:flutter/material.dart';
import 'package:root_gorge/repositories/herbicides.dart';

class Legend extends StatelessWidget {
  const Legend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text(
              'Herbicide Type',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: getHerbicides()
                    .map((herbicide) => _buildLegendRow(
                          herbicideType: herbicide.name,
                          color: herbicide.color,
                        ),)
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Row _buildLegendRow({required String herbicideType, required Color color}) {
  return Row(
    children: [
      const SizedBox(width: 10),
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 10),
      Text(herbicideType),
    ],
  );
}
