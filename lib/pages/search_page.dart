import 'package:book_store_plus/models/filter.dart';
import 'package:book_store_plus/models/literature.dart';
import 'package:book_store_plus/utils/extentions.dart';
import 'package:book_store_plus/widgets/book_card.dart';
import 'package:flutter/material.dart';

import '../widgets/filter_sheet.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Literature> books = [];
  Filter? filter;
  TextEditingController textEditingController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  void search() {
    final query = textEditingController.text.trim();
    setState(() {
      books = context.deps.booksCubit.search(query, filter: filter);
    });
  }

  @override
  void initState() {
    super.initState();
    books = context.deps.booksCubit.state;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (myFocusNode.hasFocus) {
          myFocusNode.unfocus();
          return false;
        }
        return true;
        },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Поиск"),
          actions: [
            IconButton(
              onPressed: () async {
                final result = await showModalBottomSheet<Filter>(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => FilterSheet(current: filter),
                );
      
                if (result != null) {
                  setState(() {
                    filter = result;
                  });
                  search();
                }
              },
              icon: Icon(Icons.filter_alt_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: "search",
                      child: TextField(
                        onSubmitted: (_) => search(),
                        controller: textEditingController,
                        focusNode: myFocusNode,
                      ),
                    ),
                  ),
                  IconButton(onPressed: search, icon: Icon(Icons.search)),
                ],
              ),
              books.isEmpty
                  ? Expanded(child: Center(child: Text("Ничего не найдено")))
                  : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            width > 800
                                ? 4
                                : width > 600
                                ? 3
                                : width > 400
                                ? 2
                                : 1,
                      ),
                      shrinkWrap: true,
                      itemCount: books.length,
                      itemBuilder:
                          (context, index) => BookCard(book: books[index]),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
