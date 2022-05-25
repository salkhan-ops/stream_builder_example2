import 'dart:async';

import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilderExample(),
    );
  }
}

class StreamBuilderExample extends StatefulWidget {
  const StreamBuilderExample({Key? key}) : super(key: key);

  @override
  State<StreamBuilderExample> createState() => _StreamBuilderExampleState();
}

class _StreamBuilderExampleState extends State<StreamBuilderExample> {
  final _imageStream = StreamController<Image>();
  int _imageCount = 0;

  final List imageList = <Image>[
    Image.asset(
      'assets/images/a1.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/a2.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/a3.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/a4.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/a5.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/a6.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/a7.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/a8.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/a9.jpg',
      fit: BoxFit.cover,
    ),
  ];

  @override
  void dispose() {
    _imageStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Stream Builder using Image',
            style: TextStyle(wordSpacing: 3, fontSize: 25),
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: _imageStream.stream,
                initialData: imageList[0],
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        Visibility(
                            visible: snapshot.hasData,
                            child: ImageDisplayContainer(
                              snapshot: snapshot,
                            )),
                      ],
                    );
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    return ImageDisplayContainer(
                      snapshot: snapshot,
                    );
                  } else {
                    return Text('state: ${snapshot.connectionState}');
                  }
                }),
            SizedBox(height: 100),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _imageCount == imageList.length - 1
                      ? _imageCount = 0
                      : _imageCount++;
                  _imageStream.sink.add(imageList[_imageCount]);
                },
                child: Text(
                  'Next Image'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDisplayContainer extends StatelessWidget {
  final AsyncSnapshot snapshot;
  const ImageDisplayContainer({
    super.key,
    required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: snapshot.data,
      ),
    );
  }
}
