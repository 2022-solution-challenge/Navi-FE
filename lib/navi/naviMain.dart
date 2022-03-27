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
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 100,
              child: SearchBar(setSearchData),
            ),
            SizedBox(
              height: 40.0,
            ),
            SearchResult(searchData: naviSearchData, isLoaded: isLoaded),
          ],
        ));
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBar createState() => _SearchBar();

  const SearchBar(this.changeQuery);

  final void Function(String) changeQuery;
}

class _SearchBar extends State<SearchBar> {
  static const historyLength = 5;

  String selectedTerm = "";
  FloatingSearchBarController controller = FloatingSearchBarController();

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
        backdropColor: Color.fromARGB(255, 249, 249, 249),
        elevation: 1,
        title: Text(
          (selectedTerm!="" ? selectedTerm : 'The Search App'),
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search and find out...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onSubmitted: (query) {
          setState(() {
            selectedTerm = query;
            widget.changeQuery(selectedTerm);
          });
          controller.close();
        },
        builder: (context, _) => Text(""));
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
