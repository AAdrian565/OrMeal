import 'package:flutter/material.dart';

class menuDetail extends StatelessWidget {
  final String title;
  final String imgLink;
  final String description;

  const menuDetail({
    Key? key,
    required this.title,
    required this.imgLink,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(
                imgLink,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

