import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkostel/pages/carikos.dart';

void main() {
  testWidgets('Image asset loads correctly', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageWidget(),
      ),
    ));

    // Find the Image widget
    final imageFinder = find.byType(Image);

    // Verify the Image widget
    expect(imageFinder, findsOneWidget);

    // Verify the Image asset
    final Image imageWidget = tester.widget<Image>(imageFinder);
    expect(imageWidget.image, isA<AssetImage>());
    final AssetImage assetImage = imageWidget.image as AssetImage;
    expect(assetImage.assetName, 'lib/icons/simpan_active.png');
  });

  testWidgets('Image error handled correctly', (WidgetTester tester) async {
    // Build the widget with error
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageWidget(
          isError: true,
        ),
      ),
    ));

    // Find the Icon widget
    final iconFinder = find.byIcon(Icons.error);

    // Verify the Icon widget
    expect(iconFinder, findsOneWidget);
  });
}

class ImageWidget extends StatelessWidget {
  final bool isError;

  const ImageWidget({Key? key, this.isError = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        isError
            ? Icon(Icons.error, color: Colors.red)
            : Image.asset(
                'lib/icons/simpan_active.png',
                color: Colors.grey,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
      ],
    );
  }
}
