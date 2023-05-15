import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  bool isLoading = false;
  bool darkMode = false;

  AuthButtonType? buttonType;
  AuthIconType? iconType;

  var categories = [
    {'name': 'Sports', 'value': 'SPORTS'},
    {'name': 'Music', 'value': 'MUSIC'},
    {'name': 'Technology', 'value': 'TECH'},
    {'name': 'Humanity', 'value': 'HUMANITY'},
    {'name': 'Politics', 'value': 'POLITICS  '},
    {'name': 'Education', 'value': 'EDUCATION'},
  ];

  final ScrollController _controller = ScrollController();

  ThemeMode get themeMode => darkMode ? ThemeMode.dark : ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        top: 0,
      ),
      shrinkWrap: true,
      controller: _controller,
      itemBuilder: (context, index) {
        final item = categories[index];
        return ListTile(
          horizontalTitleGap: 0,
          title: Text('${item['name']}'),
          trailing: const Icon(
            Icons.check_box_outline_blank,
            size: 24,
          ),
        );
      },
      separatorBuilder: (context, index) => Container(
        height: 2,
        color: const Color.fromARGB(255, 219, 219, 219),
      ),
      itemCount: categories.length,
    );
  }
}
