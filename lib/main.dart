import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mirrored Table Scrolling'),
        ),
        body: Center(
          child: TableWidget(),
        ),
      ),
    );
  }
}

class TableWidget extends StatefulWidget {
  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final ScrollController _leftScrollController = ScrollController();
  final ScrollController _rightScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _leftScrollController.addListener(() {
      if (_rightScrollController.hasClients) {
        _rightScrollController.jumpTo(
          _leftScrollController.position.maxScrollExtent -
              _leftScrollController.offset,
        );
      }
    });

    _rightScrollController.addListener(() {
      if (_leftScrollController.hasClients) {
        _leftScrollController.jumpTo(
          _rightScrollController.position.maxScrollExtent -
              _rightScrollController.offset,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _leftScrollController,
            child: Column(
              children: _createRows('Left'),
            ),
          ),
        ),
        Container(
          // color: Colors.grey[200],
          child: Column(
            children: _createCenterColumns(),
          ),
        ),
        Container(
          width: 120,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _rightScrollController,
            child: Column(
              children: _createRows('Right'),
            ),
          ),
        ),
        // Center part of the table
        // Expanded(
        //   child: SingleChildScrollView(
        //     scrollDirection: Axis.vertical,
        //     controller: _verticalScrollController,
        //     child: Row(
        //       children: [
        //         // Center columns
        //         ,
        //         // Right part of the table (scrolls outward)
        //         Container(
        //           width: 100,
        //           child: SingleChildScrollView(
        //             scrollDirection: Axis.horizontal,
        //             controller: _rightScrollController,
        //             child: Column(
        //               children: _createRows('Right'),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  List<Widget> _createRows(String side) {
    return List.generate(10, (rowIndex) {
      return Row(
        children: List.generate(12, (colIndex) {
          String text;
          if (colIndex == 4) {
            text = '$side Row $rowIndex, Col Strike';
          } else if (colIndex == 5) {
            text = '$side Row $rowIndex, Col IV';
          } else {
            text = '$side Row $rowIndex, Col $colIndex';
          }
          return Container(
            width: 50,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Text(text),
          );
        }),
      );
    });
  }

  List<Widget> _createCenterColumns() {
    return List.generate(10, (rowIndex) {
      return Row(
        children: [
          Container(
            width: 50,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              'Strike Row $rowIndex',
              style: TextStyle(color: Color.fromARGB(255, 22, 32, 227)),
            ),
          ),
          Container(
            width: 50,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              'IV Row $rowIndex',
              style: TextStyle(color: Color.fromARGB(255, 22, 32, 227)),
            ),
          ),
        ],
      );
    });
  }
}
