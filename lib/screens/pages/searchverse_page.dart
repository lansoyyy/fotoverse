import 'package:flutter/material.dart';
import 'package:fotoverse/widgets/text_widget.dart';

import '../../services/api_service.dart';
import '../../utils/colors.dart';
import '../../widgets/drawer_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  String nameSearched = '';

  List verses = [];

  getVerses(String search) {
    verses.clear();
    Future quotes = ApiService().getBibleVerses(search);

    quotes.then((value) {
      if (value['results'].isNotEmpty) {
        setState(() {
          verses = value['results'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(verses);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title:
            TextBold(text: 'Search Verses', fontSize: 18, color: Colors.white),
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: primary,
                  ),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  style: const TextStyle(
                      color: primary, fontFamily: 'Regular', fontSize: 14),
                  onChanged: (value) {
                    setState(() {
                      nameSearched = value;
                    });

                    getVerses(nameSearched);
                  },
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: primary,
                      ),
                      hintText: 'Search a keyword',
                      hintStyle: TextStyle(fontFamily: 'QRegular'),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                  controller: searchController,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: verses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: primary,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextBold(
                              text:
                                  '${verses[index]['content']} - ${verses[index]['reference']}',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            const Expanded(child: SizedBox()),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: TextRegular(
                                text: 'New International Version (NIV)',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
