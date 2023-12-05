import 'package:cookingenial/models/recipe_model.dart';
import 'package:cookingenial/widgets/search_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  late FocusNode _focusNode;

  Future<List<RecipeModel>>? _futureProducts;
  // Future<List<RecipeModel>> getRecipes() async {
  //   return await RecipeApi.getRecipesByParamter(_textFieldController.text);
  // }

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onEditingComplete() {
    refreshResults();
    FocusScope.of(context).unfocus();
  }

  void refreshResults() {
    // setState(() {
    //   _futureProducts = getRecipes();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search recipes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Material(
              elevation: 1.0,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        focusNode: _focusNode,
                        controller: _textFieldController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Search recipes',
                        ),
                        onEditingComplete: _onEditingComplete,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      refreshResults();
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
            Expanded(
              child: SingleChildScrollView(
                  child: FutureBuilder<List<RecipeModel>>(
                future: _futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(
                      child: Text('Error to get the recipes'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                    return const Center(
                      child: Text('recipes no found'),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var item in snapshot.data!)
                        Column(
                          children: [
                            SearchItemWidget(recipeModel: item),
                          ],
                        ),
                    ],
                  );
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
