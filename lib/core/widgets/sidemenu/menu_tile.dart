import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globipay_admin_panel/core/constants/defaults.dart';
import 'package:globipay_admin_panel/core/theme/color_palettes.dart';
import '../../theme/app_colors.dart';

class MenuTile extends StatefulWidget {
  const MenuTile({
    super.key,
    required this.title,
    this.activeIconSrc,
    this.inactiveIconSrc,
    required this.onPressed,
    this.isActive = false,
    this.isSubmenu = false,
    this.count,
    this.countBg = AppColors.secondaryMintGreen,
  });

  final String title;
  final String? inactiveIconSrc, activeIconSrc;
  final VoidCallback onPressed;
  final bool isActive, isSubmenu;
  final int? count;
  final Color countBg;

  @override
  _MenuTileState createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
      }),
      child: Padding(
        padding: EdgeInsets.only(
            left: widget.isSubmenu ? AppDefaults.padding * 2 : 0,
            right: widget.isSubmenu ? AppDefaults.padding : 0),
        child: Container(
          // Optionally add a background color when hovered
          //color: _isHovered ? AppColors.secondaryPaleYellow : Colors.transparent,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDefaults.borderRadius),
            ),
            onTap: widget.onPressed,
            leading: widget.activeIconSrc != null
                ? SvgPicture.asset(
                    (widget.isActive || widget.inactiveIconSrc == null)
                        ? widget.activeIconSrc!
                        : widget.inactiveIconSrc!,
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                        widget.isActive
                            ? Theme.of(context).iconTheme.color!
                            : Theme.of(context).textTheme.bodyMedium!.color!,
                        BlendMode.srcIn),
                  )
                : null,
            title: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: widget.isActive ? AppColors.titleLight : AppColors.textLight,
              ),
            ),
            trailing: widget.count != null
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding / 2,
                        vertical: AppDefaults.padding / 4),
                    decoration: BoxDecoration(
                      color: widget.countBg,
                      borderRadius:
                          BorderRadius.circular(AppDefaults.borderRadius / 2),
                    ),
                    child: Text(
                      widget.count.toString(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
