part of 'values.dart';

class Decorations {
  static customBoxDecoration({
    double blurRadius = 2,
    Color color = const Color(0xFFD6D7FB),
  }) {
    return BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: blurRadius, color: color)]);
  }

  static customBoxDecorationGrey({
    double blurRadius = 2,
    Color color =  const Color(0xFFd6eaf8),
  }) {
    return BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: blurRadius, color: color)]);
  }

  static containerBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        border: Border.all(color: Colors.grey[400])
    );
  }

  static containerBoxDecorationList() {
    return BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(color: Colors.grey[400])
    );
  }

  static textInputDecoration(String hint, String error, Color color) {
    return InputDecoration(
      counterText: '',
      border: WidgetHelper().outlineInputBorderTextFieldRounded(),
      errorText: error,
      fillColor: color,
      filled: true,
      hintText: hint,
      enabledBorder: WidgetHelper().outlineInputBorderTextFieldRoundedEnabled(),
      disabledBorder: WidgetHelper().outlineInputBorderTextFieldRoundedEnabled(),
      contentPadding: EdgeInsets.all(10.0),
      hintStyle: TextStyle(
        fontSize: 15.0,
        color: Colors.grey,
        fontFamily: 'Mitr',
      ),
    );
  }

  static textInputDecorationDate(String hint, String error, Color color) {
    return InputDecoration(
      counterText: '',
      border: WidgetHelper().outlineInputBorderTextFieldRounded(),
      errorText: error,
      fillColor: color,
      filled: true,
      hintText: hint,
      enabledBorder: WidgetHelper().outlineInputBorderTextFieldRoundedEnabled(),
      disabledBorder: WidgetHelper().outlineInputBorderTextFieldRoundedEnabled(),
      contentPadding: EdgeInsets.all(10.0),
      hintStyle: TextStyle(
        fontSize: 15.0,
        color: Colors.grey,
        fontFamily: 'Mitr',
      ),
      prefixIcon: Icon(Icons.calendar_today), // Add this line to display an icon before the hint text
    );
  }
}
