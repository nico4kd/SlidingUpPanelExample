import 'package:flutter/material.dart';
import 'package:slidingup_panel_example/theme/theme.dart';

class MakerButton extends StatelessWidget {
  MakerButton({
    Key? key,
    required String label,
    required void Function() onPressed,
    bool isPrimary = true,
    bool isPrincipal = true,
    bool disabled = false,
    EdgeInsetsGeometry padding = const EdgeInsets.all(32.0),
    EdgeInsetsGeometry internalPadding = const EdgeInsets.all(8.0),
  })  : _label = label,
        _isPrimary = isPrimary,
        _isPrincipal = isPrincipal,
        _disabled = disabled,
        _padding = padding,
        _internalPadding = internalPadding,
        _onPressed = onPressed,
        super(key: key);

  final String _label;
  final void Function() _onPressed;
  final bool _isPrimary;
  final bool _isPrincipal;
  final bool _disabled;
  final EdgeInsetsGeometry _padding;
  final EdgeInsetsGeometry _internalPadding;

  @override
  Widget build(BuildContext context) {
    final Color _foregroundColor = _isPrimary
        ? _isPrincipal
            ? Palette.btnPrimaryPrincipalForeground
            : Palette.btnPrimaryNoPrincipalForeground
        : _isPrincipal
            ? Palette.btnSecondaryPrincipalForeground
            : Palette.btnSecondaryNoPrincipalForeground;

    final Color _backgroundColor = _isPrimary
        ? _isPrincipal
            ? Palette.btnPrimaryPrincipalBackground
            : Palette.btnPrimaryNoPrincipalBackground
        : Palette.btnSecondaryBackground;

    final Color _disabledForegroundColor =
        _isPrimary ? Palette.btnPrimaryForegroundDisabled : Palette.btnSecondaryForegroundDisabled;

    final Color _disabledBackgroundColor =
        _isPrimary ? Palette.btnPrimaryBackgroundDisabled : Palette.btnSecondaryBackgroundDisabled;

    final double _elevation = 0;
    final BorderSide? _borderSide = BorderSide(
      color: _disabled ? _disabledForegroundColor : _foregroundColor,
    );

    var onPressed = !_disabled ? _onPressed : () => null;

    return Padding(
      padding: _padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: _disabled ? _disabledBackgroundColor : _backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          side: !_isPrimary ? _borderSide : null,
          elevation: _elevation,
        ),
        child: Padding(
          padding: _internalPadding,
          child: Text(
            _label,
            style: TextStyle(
              color: _disabled ? _disabledForegroundColor : _foregroundColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
// class MakerButton extends StatelessWidget {
//   MakerButton({
//     Key? key,
//     required String label,
//     required Color foregroundColor,
//     required Color backgroundColor,
//     Color disabledColor = disableButtonColor,
//     bool disabled = false,
//     BorderSide? borderSide,
//     required void Function() onPressed,
//     EdgeInsetsGeometry padding = const EdgeInsets.all(32.0),
//     double elevation = 2,
//   })  : _label = label,
//         _foregroundColor = foregroundColor,
//         _backgroundColor = backgroundColor,
//         _disabledColor = disabledColor,
//         _disabled = disabled,
//         //_borderSide = borderSide,
//         _onPressed = onPressed,
//         _padding = padding,
//         _elevation = elevation,
//         super(key: key);

//   final String _label;
//   final Color _foregroundColor;
//   final Color _backgroundColor;
//   final Color _disabledColor;
//   final bool _disabled;
//   final double _elevation;
//   final EdgeInsetsGeometry _padding;
//   late BorderSide? _borderSide = BorderSide();
//   final void Function() _onPressed;

//   @override
//   Widget build(BuildContext context) {
//     var onPressed = !_disabled ? _onPressed : () => null;

//     return Padding(
//       padding: _padding,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           primary: _disabled ? _disabledColor : _backgroundColor,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//           side: _borderSide,
//           elevation: _elevation,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             _label,
//             style: TextStyle(
//               color: _foregroundColor,
//               fontWeight: FontWeight.w400,
//               fontSize: 18,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
