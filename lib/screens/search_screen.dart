import 'package:flutter/material.dart';
import 'package:stock_trader/providers/detail_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:stock_trader/widgets/search_card.dart';
import '../constants.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  @override
  Widget build(BuildContext context) {
    final detailedDataProvider = Provider.of<DetailProvider>(context);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: deviceSize.height / 20,
          ),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kBlackGrey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.search,
                  size: deviceSize.width / 20,
                  color: Colors.white54,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    focusNode: FocusNode(),
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: detailedDataProvider.inputController,
                    onChanged: (_) async {
                      await detailedDataProvider.getSearchSuggestions(
                          detailedDataProvider.inputController.text);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Stock',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: deviceSize.width / 26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          detailedDataProvider.searchResultsCount == 0
              ? Expanded(
                  child: Center(
                    child: Text(
                      'Search company name!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: deviceSize.width / 26,
                      ),
                    ),
                  ),
                )
              : Expanded(
                child: ListView(
                    children: detailedDataProvider.searchResults
                        .map(
                          (e) => SearchCard(
                            title: e.values.toList()[1],
                            symbol: e.values.toList()[0],
                          ),
                        )
                        .toList(),
                  ),
              )
        ],
      ),
    );
  }
}
