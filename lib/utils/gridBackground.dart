import 'package:flutter/material.dart';
import 'package:mauto_iot/utils/IOTListProvider.dart';
import 'package:provider/provider.dart';

class GridBackgroundBuilder extends StatelessWidget {
  final double cellWidth;
  final double cellHeight;

  GridBackgroundBuilder({
    Key? key,
    required this.cellWidth,
    required this.cellHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLock = Provider.of<WidgetModel>(context, listen: false).isLocked;

    return Material(
      color: isLock ? Colors.grey : Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double viewportWidth = constraints.maxWidth;
          final double viewportHeight = constraints.maxHeight;
          final int rows = (viewportHeight / cellHeight).ceil();
          final int cols = (viewportWidth / cellWidth).ceil();

          return Stack(
            children: <Widget>[
              for (int row = 0; row < rows; row++)
                for (int col = 0; col < cols; col++)
                  Positioned(
                    left: col * cellWidth,
                    top: row * cellHeight,
                    child: Container(
                      height: cellHeight,
                      width: cellWidth,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 212, 212, 212),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

class GridBackgroundBuilder1 extends StatelessWidget {
  final double cellWidth;
  final double cellHeight;

  GridBackgroundBuilder1({
    Key? key,
    required this.cellWidth,
    required this.cellHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double viewportWidth = constraints.maxWidth;
          final double viewportHeight = constraints.maxHeight;
          final int rows = (viewportHeight / cellHeight).ceil();
          final int cols = (viewportWidth / cellWidth).ceil();

          return Stack(
            children: <Widget>[
              for (int row = 0; row < rows; row++)
                for (int col = 0; col < cols; col++)
                  Positioned(
                    left: col * cellWidth,
                    top: row * cellHeight,
                    child: Container(
                      height: cellHeight,
                      width: cellWidth,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
