import 'package:cookingenial/models/recipe_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchRecipeScreen extends StatefulWidget {
  const SearchRecipeScreen({super.key});

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  late FocusNode _focusNode;

  List<String> filter = ["Nombre", "Categorias", "Ingredientes"];

  int _selectedFilter = 0;

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
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => showCupertinoDialog<int>(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: const Text('Seleccione un filtro'),
                    content: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 25.0,
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedFilter,
                            ),
                            onSelectedItemChanged: (value) {
                              setState(() {
                                _selectedFilter = value;
                              });
                            },
                            children: List<Widget>.generate(
                              filter.length,
                              (int index) {
                                return Center(
                                  child: Text(
                                    filter[index],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CupertinoButton.filled(
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).pop(_selectedFilter);
                            });
                          },
                          child: const Text('Aceptar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              child: Row(
                children: [
                  const Icon(Icons.arrow_drop_down),
                  Text(
                    filter[_selectedFilter],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
