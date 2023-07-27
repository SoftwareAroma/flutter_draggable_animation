import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _percent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            /// background
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.amberAccent,
              ),
            ),

            /// menu button
            Positioned(
              top: 10.0,
              left: 10.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Icon(Icons.menu),
              ),
            ),

            /// sheet
            Positioned.fill(
              child: NotificationListener<DraggableScrollableNotification>(
                onNotification: (DraggableScrollableNotification notification) {
                  setState(() {
                    _percent = 2 * notification.extent - 0.8;
                  });
                  return true;
                },
                child: DraggableScrollableSheet(
                  maxChildSize: 0.9,
                  minChildSize: 0.3,
                  builder: (BuildContext context, ScrollController controller) {
                    return Material(
                      elevation: 10,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 20.0),
                            const Text(
                              "It's good to see you",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            const Text(
                              "Where are you going",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.purple[300],
                                ),
                                hintText: 'Search Destination',
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 20,
                                controller: controller,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: const Icon(Icons.location_on_outlined),
                                    title: Text("Address $index"),
                                    subtitle: Text("City $index"),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            /// choose destination
            Positioned(
              left: 0.0,
              right: 0.0,
              top: -200 * (1 - _percent),
              child: Opacity(
                opacity: _percent,
                child: const SearchDestination(),
              ),
            ),

            /// pick on map
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: -50 * (1 - _percent),
              child: Opacity(
                opacity: _percent,
                child: const SelectOnMap(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectOnMap extends StatelessWidget {
  const SelectOnMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.place_sharp,
            color: Colors.grey,
          ),
          SizedBox(width: 10.0),
          Text("Pick on map"),
        ],
      ),
    );
  }
}

class SearchDestination extends StatelessWidget {
  const SearchDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Row(
            children: <Widget>[
              BackButton(),
              Text(
                "Choose Destination",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Avenue 24 NO 219',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
                const SizedBox(height: 5.0),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    hintText: 'Where are we going?',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
