import 'package:flightapp/widgets/choice_chips.dart';
import 'package:flightapp/widgets/custom_shape_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../data/data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[
          HomeScreenTopPart(),
          SizedBox(
            height: 20.0,
          ),
          HomeScreenBottomPart()
        ],
      ),
    );
  }
}

class HomeScreenTopPart extends StatefulWidget {
  const HomeScreenTopPart({Key? key}) : super(key: key);

  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart>
    with SingleTickerProviderStateMixin {
  var selectedIndex = 0;
  var isFlightSelected = true;
  late AnimationController _animationController;

  final List<String> locations = ['Orlando', 'Los Angeles'];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 360.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade200]),
              ),
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: <Widget>[
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 16.0),
                          PopupMenuButton(
                            onSelected: (int index) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  locations[selectedIndex],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ],
                            ),
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuItem<int>>[
                              PopupMenuItem(
                                value: 0,
                                child: Text(
                                  locations[0],
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              PopupMenuItem(
                                value: 1,
                                child: Text(
                                  locations[1],
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Qual o próximo destino?',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Material(
                        elevation: 10.0,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0)),
                        child: TextField(
                          controller: TextEditingController(text: locations[1]),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 15.0),
                            suffixIcon: Material(
                              elevation: 2.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 500),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: <Widget>[
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: InkWell(
                              key: ValueKey<bool>(isFlightSelected),
                              onTap: () {
                                setState(() {
                                  isFlightSelected = true;
                                });
                              },
                              child: ChoiceChips(
                                icon: Icons.airplanemode_active,
                                name: "Voos",
                                isSelected: isFlightSelected,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: InkWell(
                              key: ValueKey<bool>(!isFlightSelected),
                              onTap: () {
                                setState(() {
                                  isFlightSelected = false;
                                });
                              },
                              child: ChoiceChips(
                                icon: Icons.hotel,
                                name: "Hoteis",
                                isSelected: !isFlightSelected,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreenBottomPart extends StatefulWidget {
  const HomeScreenBottomPart({Key? key}) : super(key: key);

  @override
  _HomeScreenBottomPartState createState() => _HomeScreenBottomPartState();
}

class _HomeScreenBottomPartState extends State<HomeScreenBottomPart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text("Vistos recentemente",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text(
                        "Ver todos (12)".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 14.5,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                AnimationLimiter(
                  child: SizedBox(
                    height: 244.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cityCards.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: cityCards[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text("Destinos em destaque",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text(
                        "Ver todos (9)".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 14.5,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.orange),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                AnimationLimiter(
                  child: SizedBox(
                    height: 244.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredCountries.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: featuredCountries[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
