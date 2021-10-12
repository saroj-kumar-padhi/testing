import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:crop/crop.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:math';

class ImageTest extends StatefulWidget {
  @override
  _ImageTestState createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  final controller = CropController(aspectRatio: 1000 / 667.0);
  double _rotation = 0;
  BoxShape shape = BoxShape.rectangle;

  void _cropImage() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cropped = await controller.crop(pixelRatio: pixelRatio);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Crop Result'),
            centerTitle: true,
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () async {
                    // final status = await Permission.storage.request();
                    // if (status == PermissionStatus.granted) {
                    //   await _saveScreenShot(cropped);
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text('Saved to gallery.'),
                    //     ),
                    //   );
                    // }
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: RawImage(
              image: cropped,
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Demo'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.link),
          onPressed: () {
            launch('https://github.com/xclud/flutter_crop');
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _cropImage,
            tooltip: 'Crop',
            icon: Icon(Icons.crop),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(8),
              child: Crop(
                onChanged: (decomposition) {
                  if (_rotation != decomposition.rotation) {
                    setState(() {
                      _rotation = ((decomposition.rotation + 180) % 360) - 180;
                    });
                  }

                  print(
                      "Scale : ${decomposition.scale}, Rotation: ${decomposition.rotation}, translation: ${decomposition.translation}");
                },
                controller: controller,
                shape: shape,
                child: Image.asset(
                  'images/sample.jpg',
                  fit: BoxFit.cover,
                ),
                /* It's very important to set `fit: BoxFit.cover`.
                   Do NOT remove this line.
                   There are a lot of issues on github repo by people who remove this line and their image is not shown correctly.
                */
                foreground: IgnorePointer(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Foreground Object',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                helper: shape == BoxShape.rectangle
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      )
                    : null,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.undo),
                tooltip: 'Undo',
                onPressed: () {
                  controller.rotation = 0;
                  controller.scale = 1;
                  controller.offset = Offset.zero;
                  setState(() {
                    _rotation = 0;
                  });
                },
              ),
              Expanded(
                child: SliderTheme(
                  data: theme.sliderTheme.copyWith(
                    trackShape: CenteredRectangularSliderTrackShape(),
                  ),
                  child: Slider(
                    divisions: 360,
                    value: _rotation,
                    min: -180,
                    max: 180,
                    label: '$_rotation°',
                    onChanged: (n) {
                      setState(() {
                        _rotation = n.roundToDouble();
                        controller.rotation = _rotation;
                      });
                    },
                  ),
                ),
              ),
              PopupMenuButton<BoxShape>(
                icon: Icon(Icons.crop_free),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Box"),
                    value: BoxShape.rectangle,
                  ),
                  PopupMenuItem(
                    child: Text("Oval"),
                    value: BoxShape.circle,
                  ),
                ],
                tooltip: 'Crop Shape',
                onSelected: (x) {
                  setState(() {
                    shape = x;
                  });
                },
              ),
              PopupMenuButton<double>(
                icon: Icon(Icons.aspect_ratio),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Original"),
                    value: 1000 / 667.0,
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    child: Text("16:9"),
                    value: 16.0 / 9.0,
                  ),
                  PopupMenuItem(
                    child: Text("4:3"),
                    value: 4.0 / 3.0,
                  ),
                  PopupMenuItem(
                    child: Text("1:1"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("3:4"),
                    value: 3.0 / 4.0,
                  ),
                  PopupMenuItem(
                    child: Text("9:16"),
                    value: 9.0 / 16.0,
                  ),
                ],
                tooltip: 'Aspect Ratio',
                onSelected: (x) {
                  controller.aspectRatio = x;
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<dynamic> _saveScreenShot(ui.Image img) async {
  var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  var buffer = byteData!.buffer.asUint8List();
  final result = await ImageGallerySaver.saveImage(buffer);
  print(result);

  return result;
}



class CenteredRectangularSliderTrackShape extends RectangularSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    ui.Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required ui.Offset thumbCenter,
    required ui.TextDirection textDirection,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    // If the slider track height is less than or equal to 0, then it makes no
    // difference whether the track is painted or not, therefore the painting
    // can be a no-op.
    if (sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are left: active, right: inactive,
    // but reversed for right to left text.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final trackCenter = trackRect.center;
    final Size thumbSize =
        sliderTheme.thumbShape!.getPreferredSize(isEnabled, isDiscrete);
    // final Rect leftTrackSegment = Rect.fromLTRB(
    //     trackRect.left + trackRect.height / 2,
    //     trackRect.top,
    //     thumbCenter.dx - thumbSize.width / 2,
    //     trackRect.bottom);
    // if (!leftTrackSegment.isEmpty)
    //   context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
    // final Rect rightTrackSegment = Rect.fromLTRB(
    //     thumbCenter.dx + thumbSize.width / 2,
    //     trackRect.top,
    //     trackRect.right,
    //     trackRect.bottom);
    // if (!rightTrackSegment.isEmpty)
    //   context.canvas.drawRect(rightTrackSegment, rightTrackPaint);

    if (trackCenter.dx < thumbCenter.dx) {
      final Rect leftTrackSegment = Rect.fromLTRB(
          trackRect.left,
          trackRect.top,
          min(trackCenter.dx, thumbCenter.dx - thumbSize.width / 2),
          trackRect.bottom);
      if (!leftTrackSegment.isEmpty) {
        context.canvas.drawRect(leftTrackSegment, inactivePaint);
      }

      final activeRect = Rect.fromLTRB(
          trackCenter.dx, trackRect.top, thumbCenter.dx, trackRect.bottom);
      if (!activeRect.isEmpty) {
        context.canvas.drawRect(activeRect, activePaint);
      }

      final Rect rightTrackSegment = Rect.fromLTRB(
          thumbCenter.dx + thumbSize.width / 2,
          trackRect.top,
          trackRect.right,
          trackRect.bottom);
      if (!rightTrackSegment.isEmpty) {
        context.canvas.drawRect(rightTrackSegment, inactivePaint);
      }
    } else if (trackCenter.dx > thumbCenter.dx) {
      final Rect leftTrackSegment = Rect.fromLTRB(trackRect.left, trackRect.top,
          thumbCenter.dx + thumbSize.width / 2, trackRect.bottom);
      if (!leftTrackSegment.isEmpty) {
        context.canvas.drawRect(leftTrackSegment, inactivePaint);
      }

      final activeRect = Rect.fromLTRB(
          thumbCenter.dx, trackRect.top, trackCenter.dx, trackRect.bottom);
      if (!activeRect.isEmpty) {
        context.canvas.drawRect(activeRect, activePaint);
      }

      final Rect rightTrackSegment = Rect.fromLTRB(
          min(trackCenter.dx, thumbCenter.dx - thumbSize.width / 2),
          trackRect.top,
          trackRect.right,
          trackRect.bottom);
      if (!rightTrackSegment.isEmpty) {
        context.canvas.drawRect(rightTrackSegment, inactivePaint);
      }
    } else {
      final Rect leftTrackSegment = Rect.fromLTRB(
          trackRect.left,
          trackRect.top,
          min(trackCenter.dx, thumbCenter.dx - thumbSize.width / 2),
          trackRect.bottom);
      if (!leftTrackSegment.isEmpty) {
        context.canvas.drawRect(leftTrackSegment, inactivePaint);
      }

      final Rect rightTrackSegment = Rect.fromLTRB(
          min(trackCenter.dx, thumbCenter.dx - thumbSize.width / 2),
          trackRect.top,
          trackRect.right,
          trackRect.bottom);
      if (!rightTrackSegment.isEmpty) {
        context.canvas.drawRect(rightTrackSegment, inactivePaint);
      }
    }
  }
}