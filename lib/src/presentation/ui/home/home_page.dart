import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poddy_caster/_components/colors.dart';
import 'package:poddy_caster/src/data/sample_json.dart';
import 'package:poddy_caster/src/utils/data_for_dynamic.dart';
import 'package:poddy_caster/src/utils/util_widgets.dart';
import 'package:poddy_caster/src/presentation/ui/single_page_ui/player.dart';
import 'package:poddy_caster/src/presentation/ui/single_page_ui/search.dart';
import 'package:poddy_caster/src/utils/important_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double scrollValue = 1;
  final int _carouselIndex = 2;
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                // Get.to(
                //   () => const SearchPage(),
                //   transition: Transition.circularReveal,
                //   duration: const Duration(seconds: 1),
                // );
                navigateRoute(context, const SearchPage());
              },
              icon: const Icon(Icons.search, size: 26)),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        color: pPrimaryTextColor,
        backgroundColor: pDeepPrimary,
        onRefresh: () async {
          setState(() {
            _loading = false;
          });
          Timer(const Duration(milliseconds: 1500), () {
            setState(() {
              _loading = true;
            });
          });
        },
        child: Visibility(
          visible: _loading,
          replacement: const Center(
              child: CircularProgressIndicator(color: pPrimaryTextColor)),
          child: Stack(
            children: [
              Container(
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: scrollValue,
                    fit: BoxFit.fitHeight,
                    image: const AssetImage('assets/images/slider1.jpg'),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: AppConfig.height80),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              4,
                              (index) => DotCarousel(
                                  active:
                                      _carouselIndex == index ? true : false),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppConfig.height60 * 2,
                          width: AppConfig.screenWidth - 60,
                          child: ListView.builder(
                              itemCount: homeTopSliderOne.length,
                              itemBuilder: (BuildContext context, int index) {
                                return HoriCarousel(
                                  ind: index,
                                  list: homeTopSliderOne,
                                );
                              }),
                        ),
                      ],
                    ),
                    // ! this is for the carousel slider
                    Column(
                      children: [
                        SizedBox(height: AppConfig.height50),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Popular Broadcast",
                              style: TextStyle(
                                color: pWhite,
                                fontSize: AppConfig.textSize18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppConfig.height10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(left: AppConfig.width10),
                            child: Row(
                              children: List.generate(homeCarouselSlider.length,
                                  (index) {
                                return CarouselCardHome(
                                    objData: homeCarouselSlider[index]);
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppConfig.height20),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          NormalText(
                            text: "Similar Broadcast",
                            isBold: true,
                            textSize: AppConfig.textSize18,
                            textColor: pWhite,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppConfig.height20),
                    Column(
                      children: List.generate(
                        homeCardBottom.length,
                        (index) {
                          return Column(
                            children: [
                              ListCardBottomHome(
                                homeCardBottom[index],
                                () {
                                  navigateRoute(
                                      context,
                                      PlayerPage(
                                          data: radioPopularBroadCard[index]));
                                },
                              ),
                              SizedBox(height: AppConfig.height10),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}