import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
          8,
          (index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.category),
                  SizedBox(height: 5),
                  Text('Category'),
                ],
              )),
    );
  }
}
