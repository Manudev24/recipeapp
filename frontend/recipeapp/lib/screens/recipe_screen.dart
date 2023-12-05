import 'package:better_player/better_player.dart';
import 'package:cookingenial/models/recipe_model.dart';
import 'package:cookingenial/services/api/recipe_api.dart';
import 'package:cookingenial/utils/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shimmer/shimmer.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({
    super.key,
  });

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  String? _id;
  Future<RecipeModel>? _futureRecipes;

  int currentIndex = 0;

  late BetterPlayerController _betterPlayerController;
  final GlobalKey<LikeButtonState> _globalKey = GlobalKey<LikeButtonState>();

  void loadVideo() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      aspectRatio: 9 / 16,
      fit: BoxFit.contain,
      autoDetectFullscreenDeviceOrientation: true,
      autoDispose: false,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        '${apiUrl}/recipe/get-video/${_id!}');
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  final int likeCount = 999;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  //Issue when textfield is focused
  var isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Load id from argument
    if (isLoaded == false) {
      _id = ModalRoute.of(context)?.settings.arguments as String?;
      //Load video from server
      loadVideo();
      //Load recipe from server
      _futureRecipes = RecipeApi.getRecipesById(_id!);
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<Widget> sliders = [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(_id),
            ),
          );
        },
        child: ClipRRect(
          child: Hero(
            tag: _id!,
            child: Container(
              color: Colors.transparent,
              child: Image(
                image: NetworkImage('${apiUrl}/recipe/get-image/${_id!}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      SafeArea(
        child: BetterPlayer(controller: _betterPlayerController),
      ),
    ];
    final handle = SliverOverlapAbsorberHandle();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: deviceSize.height * 0.45,
            floating: false,
            pinned: false,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterCarousel(
                options: CarouselOptions(
                  autoPlay: false,
                  disableCenter: true,
                  viewportFraction: deviceSize.width > 900.0 ? 0.8 : 1.0,
                  height: deviceSize.height * 0.45,
                  indicatorMargin: 12.0,
                  enableInfiniteScroll: true,
                  slideIndicator: const CircularSlideIndicator(),
                ),
                items: sliders,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return FutureBuilder<RecipeModel>(
                  future: _futureRecipes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none) {
                      return Container();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 130.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 130.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(
                        child: Text('Error al cargar receta'),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('Sin receta'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              LikeButton(
                                size: 40,
                                likeCount: likeCount,
                                key: _globalKey,
                                isLiked: true,
                                postFrameCallback: (LikeButtonState state) {
                                  state.controller?.forward();
                                },
                                countPostion: CountPostion.bottom,
                                countBuilder:
                                    (int? count, bool isLiked, String text) {
                                  final ColorSwatch<int> color =
                                      isLiked ? Colors.pinkAccent : Colors.grey;
                                  Widget result;

                                  result = Text(
                                    count! >= 1000
                                        ? (count / 1000.0).toStringAsFixed(1) +
                                            'k'
                                        : text,
                                    style: TextStyle(
                                      color: color,
                                    ),
                                    textAlign: TextAlign.center,
                                  );
                                  return result;
                                },
                                likeCountAnimationType: likeCount < 1000
                                    ? LikeCountAnimationType.part
                                    : LikeCountAnimationType.none,
                                likeCountPadding: const EdgeInsets.all(0),
                                onTap: onLikeButtonTapped,
                              ),
                            ],
                          ),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              for (var item in snapshot.data!.categories!)
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Descripción',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.description!,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Ingredients',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  for (var item in snapshot.data!.items!)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          item.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        for (var ingredients
                                            in item.ingredients)
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              //CupertinoContextMenu
                                              CupertinoContextMenu(
                                                actions: [
                                                  CupertinoContextMenuAction(
                                                    child: const Text(
                                                      'Cerrar',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    trailingIcon: CupertinoIcons
                                                        .multiply_circle_fill,
                                                  ),
                                                ],
                                                child: Material(
                                                  elevation: 3,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          child: Image(
                                                            image: NetworkImage(
                                                                '${apiUrl}/ingredient/get-image/${ingredients.id}'),
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ingredients.name,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${ingredients.proportion}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                previewBuilder: (BuildContext
                                                        context,
                                                    Animation<double> animation,
                                                    Widget child) {
                                                  return CupertinoApp(
                                                    home: SingleChildScrollView(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Center(
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  child: Image(
                                                                    image: NetworkImage(
                                                                        '${apiUrl}/ingredient/get-image/${ingredients.id}'),
                                                                    width: 300,
                                                                    height: 300,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                ingredients
                                                                    .name,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                              Text(
                                                                ingredients
                                                                    .description!,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          )
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Widget for instrctions
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Instrucciones',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  for (var item in snapshot.data!.instructions!)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${item.stepNumber}. ${item.title}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          item.description,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Qualification 0 - 5 stars
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Comentario',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      //Button for view comments, show a ModalBottomSheet (showModalBottomSheet)
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Comentarios',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    //Listview for comments
                                                    Expanded(
                                                      child: ListView.builder(
                                                        itemCount: 10,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            leading:
                                                                CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey,
                                                                    child: Icon(
                                                                      CupertinoIcons
                                                                          .person,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                            title: Text(
                                                              'Usuario $index',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                                'Comentario $index'),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          CupertinoIcons.chat_bubble,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      for (var i = 0;
                                          i < snapshot.data!.qualification!;
                                          i++)
                                        Icon(
                                          CupertinoIcons.star_fill,
                                          color: Colors.yellow[700],
                                        ),
                                      for (var i = 0;
                                          i <
                                              (5 -
                                                  snapshot
                                                      .data!.qualification!);
                                          i++)
                                        Icon(
                                          CupertinoIcons.star_fill,
                                          color: Colors.grey[300],
                                        ),
                                    ],
                                  ),
                                  //InputText for comment
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  TextField(
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      hintText: 'Escribe tu comentario',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Comentar'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String? _id;
  DetailScreen(this._id);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final PhotoViewController _controller;
  late final PhotoViewScaleStateController _scaleStateController;

  @override
  void initState() {
    super.initState();
    _controller = PhotoViewController();
    _scaleStateController = PhotoViewScaleStateController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_scaleStateController.scaleState == PhotoViewScaleState.initial) {
            Navigator.pop(context);
          }
        },
        onVerticalDragEnd: (details) {
          if (_scaleStateController.scaleState == PhotoViewScaleState.initial) {
            Navigator.pop(context);
          }
        },
        child: Center(
          child: Hero(
            tag: widget._id!,
            child: Container(
              color: Colors.transparent,
              child: PhotoView(
                controller: _controller,
                scaleStateController: _scaleStateController,
                imageProvider:
                    NetworkImage('${apiUrl}/recipe/get-image/${widget._id!}'),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scaleStateController.dispose();
    super.dispose();
  }
}
