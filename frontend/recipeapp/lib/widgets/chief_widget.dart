import 'package:flutter/material.dart';

class ChiefWidget extends StatefulWidget {
  final String id;
  const ChiefWidget({super.key, required this.id});

  @override
  State<ChiefWidget> createState() => _ChiefWidgetState();
}

class _ChiefWidgetState extends State<ChiefWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 250,
      padding: EdgeInsets.only(right: 10),
      // color: Colors.grey,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          '/chiefScreen',
          arguments: widget.id,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Hero(
                  tag: widget.id,
                  child: Image(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1576237680582-75be01432ca6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              'Juan Martinez',
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
