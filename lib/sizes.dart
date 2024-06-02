import 'dart:ui';

const defaultWindowSize = Size(710, 200);
const defaultNumberSize = Size(100, 200);

const minWidth = 200.0;
final minWindowSize = Size(minWidth, minWidth / defaultWindowSize.aspectRatio);

Size realNumberSize(Size windowSize) {
  final realSize = calcAvailableSize(windowSize);
  return Size(
      defaultNumberSize.width / defaultWindowSize.width * realSize.width,
      defaultNumberSize.height / defaultWindowSize.height * realSize.height);
}

double timeAreaGapSize(Size windowSize) {
  final realSize = calcAvailableSize(windowSize);
  return 10 / defaultWindowSize.height * realSize.height;
}

double numberGroupGapSize(Size windowSize) {
  final realSize = calcAvailableSize(windowSize);
  return 10 / defaultWindowSize.height * realSize.height;
}

double dotSize(Size windowSize) {
  final realSize = calcAvailableSize(windowSize);
  return 10 / defaultWindowSize.height * realSize.height;
}

double splitterGapSize(Size windowSize) {
  final realSize = calcAvailableSize(windowSize);
  return 20 / defaultWindowSize.height * realSize.height;
}

Size calcAvailableSize(Size windowSize) {
  final height = windowSize.width / defaultWindowSize.aspectRatio;
  if (height <= windowSize.height) {
    return Size(windowSize.width, height);
  } else {
    return Size(
        windowSize.height * defaultWindowSize.aspectRatio, windowSize.height);
  }
}
