
import 'package:flutter/material.dart';

import 'components/table_basic.dart';

class HomePage extends StatefulWidget  {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Basics'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TableBasic()),
              ),
            ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Range Selection'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableRangeExample()),
            //   ),
            // ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Events'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableEventsExample()),
            //   ),
            // ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Multiple Selection'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableMultiExample()),
            //   ),
            // ),
            // const SizedBox(height: 12.0),
            // ElevatedButton(
            //   child: Text('Complex'),
            //   onPressed: () => Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (_) => TableComplexExample()),
            //   ),
            // ),
            // const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}