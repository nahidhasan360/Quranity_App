import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quranity/app/theme/app_colors.dart';

/// ============================================================================
/// ACCOUNT MENU ITEM WIDGET - Professional & Production Ready
/// ============================================================================
/// Features:
/// - Smooth tap animations
/// - Badge support
/// - Destructive action styling
/// - Professional shadows and borders
/// - Haptic feedback ready
/// - Accessibility support
/// ============================================================================

class AccountMenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String? badge;
  final bool isDestructive;

  const AccountMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = AppColors.primaryGold,
    this.iconBackgroundColor = AppColors.medGrey,
    this.badge,
    this.isDestructive = false,
  });

  @override
  State<AccountMenuItem> createState() => _AccountMenuItemState();
}

class _AccountMenuItemState extends State<AccountMenuItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: _isPressed
                ? []
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                // Icon Container
                _buildIconContainer(),

                SizedBox(width: 16.w),

                // Title
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: widget.isDestructive
                          ? Colors.red
                          : AppColors.textPrimary,
                      fontFamily: 'SF Pro',
                      letterSpacing: 0.1,
                    ),
                  ),
                ),

                // Badge (if exists)
                if (widget.badge != null) ...[
                  _buildBadge(),
                  SizedBox(width: 12.w),
                ],

                // Arrow Icon
                Icon(
                  Icons.chevron_right,
                  color: widget.isDestructive
                      ? Colors.red.withOpacity(0.7)
                      : AppColors.iconWhite.withOpacity(0.6),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Icon Container with Professional Styling
  Widget _buildIconContainer() {
    return Container(
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        color: widget.isDestructive
            ? Colors.red.withOpacity(0.1)
            : widget.iconBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Icon(
          widget.icon,
          color: widget.isDestructive ? Colors.red : widget.iconColor,
          size: 22.sp,
        ),
      ),
    );
  }

  /// Badge Widget with Professional Styling
  Widget _buildBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primaryGold.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.primaryGold.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        widget.badge!,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryGold,
          fontFamily: 'SF Pro',
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

/// ============================================================================
/// DEPRECATED: Old AppBar Widget (Replaced with inline implementation)
/// ============================================================================
/// Kept for backward compatibility but not recommended for new code
/// Use the inline app bar in AccountScreen instead
/// ============================================================================

@Deprecated('Use inline app bar in AccountScreen for better customization')
class AccountAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;

  const AccountAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: onBackPressed,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.iconWhite,
                size: 18.sp,
              ),
            ),
          ),

          // Title (Centered)
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),
          ),

          // Spacer to balance back button
          SizedBox(width: 40.w),
        ],
      ),
    );
  }
}