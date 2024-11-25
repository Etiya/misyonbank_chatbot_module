import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.imageProvider,
    this.closeAction,
  });

  final ImageProvider imageProvider;
  final VoidCallback? closeAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: PhotoView(
                imageProvider: imageProvider,
                loadingBuilder: (_, __) => const Center(
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: IconButton(
                onPressed: () => closeAction?.call(),
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
