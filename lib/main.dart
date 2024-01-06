import 'package:flutter/material.dart';
import 'package:text_to_image/api/rest.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        title: const Text( "Wonderland",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://torybarber.com/wp-content/uploads/2023/10/tb-illustrator-vector-ai-feat-01.webp"
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter text to generate image',
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelStyle: const TextStyle(color: Colors.red),
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  convertTextToImage(textController.text, context);
                  isLoading = true;

                  setState(() {});
                },
                child: isLoading
                    ? const SizedBox(
                    height: 15,
                    width: 15,
                    child:
                    CircularProgressIndicator(color: Colors.black))
                    : const Text('Generate Image',
                    style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
