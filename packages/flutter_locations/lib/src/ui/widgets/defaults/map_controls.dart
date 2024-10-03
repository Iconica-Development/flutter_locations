import "package:flutter/material.dart";

///
class DefaultLocationsMapControl extends StatefulWidget {
  ///
  const DefaultLocationsMapControl({
    required this.onTap,
    required this.icon,
    super.key,
  });

  ///
  final VoidCallback onTap;

  ///
  final IconData icon;

  ///
  static Widget builder(
    BuildContext context,
    IconData icon,
    VoidCallback onTap,
  ) =>
      DefaultLocationsMapControl(
        icon: icon,
        onTap: onTap,
      );

  @override
  State<DefaultLocationsMapControl> createState() =>
      _DefaultLocationsMapControlState();
}

class _DefaultLocationsMapControlState
    extends State<DefaultLocationsMapControl> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
        onHover: (value) => setState(() => _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        child: SizedBox(
          height: 36.0,
          width: 36.0,
          child: FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: widget.onTap,
            hoverColor: Colors.white,
            backgroundColor: Colors.white,
            mini: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Icon(
              widget.icon,
              color: _isHovered ? Colors.black : Colors.grey,
              size: 24.0,
            ),
          ),
        ),
      );
}
