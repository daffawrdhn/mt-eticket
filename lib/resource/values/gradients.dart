part of values;

class Gradients {
  static const LinearGradient gradientPrimary = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff25bfb2), Color(0xff3184b6)]
  );

  static const LinearGradient gradientHeader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.0,
        0.9,
      ],
      colors: [Color(0xffffffff), Color(0xff85C1E9)]
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.green,
      AppColors.greenShade1,
    ],
  );

  static const LinearGradient curvesGradient1 = LinearGradient(
    colors: [
      AppColors.orange,
      AppColors.orangeShade1,
      AppColors.deepOrange,
    ],
  );

  static const LinearGradient curvesGradient2 = LinearGradient(
    colors: [
      AppColors.seaBlue3,
      AppColors.seaBlue2,
      AppColors.seaBlue1,
    ],
  );

  static const LinearGradient curvesGradient3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF88CEBC),
      Color(0xFF69C7C6),
    ],
  );

  static const Gradient headerOverlayGradient = LinearGradient(
    begin: Alignment(0.51436, 1.07565),
    end: Alignment(0.51436, -0.03208),
    stops: [
      0,
      0.17571,
      1,
    ],
    colors: [
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(255, 8, 8, 8),
      Color.fromARGB(105, 45, 45, 45),
    ],
  );
}
