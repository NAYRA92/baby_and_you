import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chat_page.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String _apiKey = comaiCodeApi;

class _HomePageState extends State<HomePage> {
  late final GenerativeModel _helloModel;
  late final ChatSession _chat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _helloModel = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: _apiKey,
        systemInstruction: Content("model", [
          // Add your system instructions here as a TextPart
          TextPart(
              'You are an assistant for women in pregnant and after birth'),
          TextPart(
              'You create a random greeting message of two lines to encourage and cheer up them'),
          TextPart('You are creating a new phrase everytime.'),
        ]));
    _chat = _helloModel.startChat();
    _greetingMessage("A greeing message, with more than one emoji emoji");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(fontSize: 34),
                ),
                Text(
                  _generatedGreetingMessage.isEmpty
                      ? ""
                      : _generatedGreetingMessage.first!,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: CarouselView(
                //shift and mouse wheel to scroll horizontaly
                scrollDirection: Axis.horizontal,
                onTap: (value) {
                  value == 0
                      ? launchUrl(Uri.parse(
                          "https://www.google.com/maps/search/hospital/@12.9889975,44.9170525,12z"))
                      : value == 1
                          ? launchUrl(Uri.parse(
                              "https://www.nhs.uk/live-well/eat-well/how-to-eat-a-balanced-diet/eight-tips-for-healthy-eating/"))
                          : value == 2
                              ? launchUrl(
                                  Uri.parse("https://www.themom.co/home"))
                              : null;
                },
                itemExtent: 400,
                children: [
                  linearListContainer("BABY CARE CENTERS", "baby_care",
                      kHoneydew, kFern_green, () {}),
                  linearListContainer("HEALTHY TIPS", "food_tips", kHoneydew,
                      kFern_green, () {}),
                  linearListContainer("MOMS COMMUNITY", "mom_community",
                      kHoneydew, kFern_green, () {}),
                ]),
          ),
          Divider(
            thickness: 1.5,
            indent: 30,
            endIndent: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "mommy tips 👶",
                  style: TextStyle(fontSize: 34),
                ),
                Text(
                  "Youtube Videos",
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: ListView(
                children: [
                  Container(
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          child: linearListContainer(
                              "CHANGE FOR BABY",
                              "change_baby",
                              const Color.fromARGB(255, 122, 26, 58),
                              kHoneydew, () {
                            launchUrl(Uri.parse(
                                "https://youtu.be/cDa2BTZppUc?si=DHJKrvnfPd5d4idW"));
                          }),
                        ),
                        Expanded(
                          child: linearListContainer(
                              "BABY FEEDING",
                              "feed_baby",
                              const Color.fromARGB(255, 122, 80, 26),
                              kHoneydew, () {
                            launchUrl(Uri.parse(
                                "https://www.youtube.com/watch?v=7k6kNaUb79Q"));
                          }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child: linearListContainer("BABY FIRST AID",
                        "first_aid", kFern_green, kHoneydew, () {
                      launchUrl(Uri.parse("https://www.youtube.com/watch?v=uZYptqxfZ1E"));
                    }),
                  ),
                ],
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_generatedGreetingMessage);
          showDialog(
              context: context,
              builder: (BuildContext) {
                return AlertDialog(
                  content: Container(
                    height: 350,
                    width: 350,
                    child: Column(
                      children: [
                        Expanded(
                          child: ChatScreen(),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        tooltip: "Smart Chatbot",
        backgroundColor: kFern_green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assistant,
              color: kHoneydew,
            ),
            Text(
              "GET HELP",
              style: TextStyle(
                  fontSize: 11, color: kHoneydew, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  final List<String?> _generatedGreetingMessage = <String?>[];
  Future<void> _greetingMessage(String message) async {
    try {
      // _generatedGreetingMessage.add((message));
      final response = await _chat.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      _generatedGreetingMessage.add((text));

      if (text == null) {
        //this should be replaying null
        // _showError('No response from API.');
        return;
      } else {
        setState(() {
          // _loading = false;
          // _scrollDown();
        });
      }
    } catch (e) {
      // _showError(e.toString());
      setState(() {
        // _loading = false;
      });
    } finally {
      // _textController.clear();
      setState(() {
        // _loading = false;
      });
      // _textFieldFocus.requestFocus();
    }
  }

  Widget linearListContainer(
      String title, String image, Color clr, Color fontClr, Function() fun) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: clr,
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("assets/images/$image.jpg"),
                opacity: .3,
                fit: BoxFit.cover)),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: fontClr, fontSize: 34),
        )),
      ),
    );
  }
}
