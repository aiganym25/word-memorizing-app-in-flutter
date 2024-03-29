import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senior_project/pages/feed-home/experiment/result_page.dart';

class FillInWords extends StatefulWidget {
  final List<dynamic> listOfWords;
  final int len;
  final int id;
  const FillInWords({Key? key, required this.listOfWords, required this.len, required this.id})
      : super(key: key);

  @override
  State<FillInWords> createState() => _FillInWordsState();
}

class _FillInWordsState extends State<FillInWords> {
  final List<TextEditingController>? _controllers = [];
  late List<String> words;

  @override
  void initState() {
    words = List.filled(widget.len, "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(102, 191, 186, 1),
            Color.fromRGBO(143, 137, 241, 0.85),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Text(
                        'Enter the words you remember in any order',
                        style: GoogleFonts.livvic(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: ListView.builder(
                          itemCount: widget.listOfWords.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            _controllers!.add(TextEditingController());
                            return Container(
                              margin: const EdgeInsets.only(bottom: 32),
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                  controller: _controllers![index],
                                  onChanged: (value) {
                                    setState(() {
                                      words[index] = _controllers![index].text;
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                  style: GoogleFonts.livvic(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 22),
                                  decoration: const InputDecoration(
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.only(left: 15, bottom: 15),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  )),
                            );
                          }),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                Result(enteredWords: words, words: widget.listOfWords, id: widget.id),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromRGBO(131, 89, 227, 1),
                        ),
                        child: const Center(
                          child: Text('Submit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
