import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      autofocus: true,
                      // controller: _textFieldController,
                      decoration: InputDecoration(
                        // prefixIcon: UnconstrainedBox(
                        //   child: SvgPicture.asset(
                        //     'assets/icons/magnifyingIcon.svg',
                        //   ),
                        // ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Search recipes',
                      ),
                      // onEditingComplete: _onEditingComplete,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // refreshResults();
                  },
                  child: UnconstrainedBox(
                    child: SvgPicture.asset(
                      'assets/icons/magnifyingIcon.svg',
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
