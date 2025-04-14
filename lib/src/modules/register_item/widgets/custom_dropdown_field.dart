import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class CustomDropdownField extends StatefulWidget {
  final String? value;
  final List<String> items;
  final String hint;
  final Function(String)? onChanged;
  final bool enabled;

  const CustomDropdownField({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    required this.hint,
    this.enabled = true,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  String? selectedValue;
  final GlobalKey _fieldKey = GlobalKey();
  bool _isOpen = false;

  late AnimationController _iconRotationController;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    _iconRotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() => _isOpen = !_isOpen);
    _animateIcon();
  }

  void _animateIcon() {
    if (_isOpen) {
      _iconRotationController.forward();
    } else {
      _iconRotationController.reverse();
    }
  }

  void _showOverlay() {
    final renderBox = _fieldKey.currentContext!.findRenderObject() as RenderBox;
    final fieldSize = renderBox.size;
    final fieldOffset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: fieldOffset.dx,
        top: fieldOffset.dy + fieldSize.height + 16,
        width: fieldSize.width,
        child: Material(
          color: Colors.transparent,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, fieldSize.height + 16),
            child: AnimatedDropdownContent(
              items: widget.items,
              selectedValue: selectedValue,
              onItemSelected: (item) {
                setState(() => selectedValue = item);
                widget.onChanged?.call(item);
                _removeOverlay();
                setState(() => _isOpen = false);
                _animateIcon();
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _iconRotationController.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = context.bodyLarge!.copyWith(fontSize: 16);
    final decoration = context.textFieldDecoration.copyWith(
      fillColor: widget.enabled
          ? context.surfaceColor
          : context.surfaceColor.withOpacity(0.5),
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: InputDecorator(
          key: _fieldKey,
          decoration: decoration.copyWith(
            fillColor: context.lightGreyColor.withOpacity(0.2),
            filled: !widget.enabled,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                width: 1,
                color: _isOpen ? context.blueColor : context.lightGreyColor,
              ),
            ),
            suffixIcon: RotationTransition(
              turns:
                  Tween(begin: 0.0, end: 0.5).animate(_iconRotationController),
              child: Icon(
                Icons.arrow_drop_down,
                color: widget.enabled
                    ? context.primaryColor
                    : context.lightGreyColor,
              ),
            ),
          ),
          child: Text(
            selectedValue ?? widget.hint,
            style: (selectedValue == null
                    ? textStyle.copyWith(
                        color: context.lightGreyColor.withOpacity(0.5))
                    : textStyle)
                .copyWith(
                    color: widget.enabled
                        ? null
                        : context.lightGreyColor.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}

class AnimatedDropdownContent extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final void Function(String) onItemSelected;

  const AnimatedDropdownContent({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onItemSelected,
  });

  @override
  State<AnimatedDropdownContent> createState() =>
      _AnimatedDropdownContentState();
}

class _AnimatedDropdownContentState extends State<AnimatedDropdownContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _opacityAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _scaleAnim = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            color: context.surfaceColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.lightGreyColor),
          ),
          child: ListView(
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            children: widget.items.map((item) {
              final isSelected = item == widget.selectedValue;
              return GestureDetector(
                onTap: () => widget.onItemSelected(item),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.blueColor.withOpacity(0.2)
                        : context.surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item,
                          style: context.bodyLarge!.copyWith(fontSize: 16),
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check, color: context.primaryColor),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
