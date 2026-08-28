import 'package:flutter/material.dart';
import 'package:idee_pet/lib.dart';

/// Individual bounding box
class BoxWidget extends StatelessWidget {
  final Recognition result;

  const BoxWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // Color for bounding box
    Color color = Colors.primaries[
        (result.label.length + result.label.codeUnitAt(0) + result.id) %
            Colors.primaries.length];

    if (result.label.contains('dog')) {
      result.label = 'Cachorro';
    } else if (result.label.contains('cat')) {
      result.label = 'Gato';
    }

    return Positioned(
      left: result.renderLocation.left,
      top: result.renderLocation.top,
      width: result.renderLocation.width,
      height: result.renderLocation.height,
      child: Container(
        width: result.renderLocation.width,
        height: result.renderLocation.height,
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(2))),
        child: Align(
          alignment: Alignment.topLeft,
          child: FittedBox(
            child: Container(
              color: color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //  Text(result.label),
                  // Text(" ${result.score.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatsWidget extends StatelessWidget {
  final String left;
  final String right;

  const StatsWidget(this.left, this.right, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(left), Text(right)],
        ),
      );
}
