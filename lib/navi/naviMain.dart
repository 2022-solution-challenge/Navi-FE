import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mapModel/mapDest.dart';
import 'searchLocationModel/searchData.dart';
import 'searchLocationModel/searchDataModel.dart';
import 'searchLocationModel/searchDataRepository.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class NaviApp extends StatefulWidget {
  const NaviApp({Key? key}) : super(key: key);

  @override
  State<NaviApp> createState() => NaviAppState();
}

class NaviAppState extends State<NaviApp> {
  bool isLoaded = false;
  SearchData? naviSearchData;
  void setSearchData(String query) async {
    //잘못 눌렸을 경우 대비용 null BTN
    if (query == null) {
      return;
    }
    SearchData? nowData = await SearchRepository().getInfomation(name: query);
    setState(() {
      isLoaded = true;
      naviSearchData = nowData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _description(),
            Expanded(
      child: SearchBar(),
    ),
            SizedBox(
              height: 20.0,
            ),
            ToGoInput(setSearchData),
            SizedBox(
              height: 40.0,
            ),
            SearchResult(searchData: naviSearchData, isLoaded: isLoaded),
          ],
        ));
  }
}

//Make StateFul widget
class ToGoInput extends StatefulWidget {
  const ToGoInput(this.changeQuery);

  final void Function(String) changeQuery;

  @override
  State<ToGoInput> createState() => ToGoInputState();
}

class ToGoInputState extends State<ToGoInput> {
  final textController = TextEditingController();
  String textToFind = "";
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search destination',
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          OutlinedButton(
            onPressed: () {
              textToFind = textController.text;
              widget.changeQuery(textToFind);
            },
            child: Text("Find"),
          ),
        ],
      ),
    );
  }
}

Widget _description() {
  return Padding(
    padding: EdgeInsets.only(left: 16, bottom: 16, top: 60),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Where to Go?',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Search',
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    ),
  );
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  static const historyLength = 5;


  late List<String> filteredSearchHistory;

  String selectedTerm = "";


  FloatingSearchBarController controller =  FloatingSearchBarController();

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: controller,
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      title: Text(
        selectedTerm ?? 'The Search App',
        style: Theme.of(context).textTheme.headline6,
      ),
      hint: 'Search and find out...',
      actions: [
        FloatingSearchBarAction.searchToClear(),
      ],
      onSubmitted: (query) {
        setState(() {
          selectedTerm = query;
        });
        controller.close();
      },
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Builder(
              builder: (context) {
                if (controller.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: 100,
                    alignment: Alignment.center,
                    child: Text(
                      'Start searching',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {

                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                selectedTerm = term;
                              });
                              controller.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
