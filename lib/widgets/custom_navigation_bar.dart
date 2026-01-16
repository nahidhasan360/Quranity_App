// custom_navbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quranity/app/theme/app_colors.dart';
import '../app/routes/app_routes.dart';


class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});



  @override
  Widget build(BuildContext context) {
    // Initialize controller once
    final controller = Get.put(NavController(), permanent: true);

    // Update navbar based on current route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updateFromCurrentRoute();
    });

    return GetBuilder<NavController>(
      id: NavController.updateId,
      builder: (controller) {
        return Container(
          height: 75,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0C0C0C),
            border: Border(
              top: BorderSide(
                color: AppColors.borderColor,
                width: 0.1,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: controller.navItems
                  .asMap()
                  .entries
                  .map((entry) => _NavItem(
                index: entry.key,
                item: entry.value,
                isSelected: controller.selectedIndex.value == entry.key,
                onTap: () => controller.navigateTo(entry.key, entry.value.route),
              ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

/// Individual navigation item widget with animations
class _NavItem extends StatefulWidget {
  final int index;
  final NavItemModel item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.6).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.isSelected) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_NavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = AppColors.primaryGold;
    const unselectedColor = Colors.white;

    return GestureDetector(
      onTap: () {
        // Haptic feedback
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
        widget.onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: widget.isSelected ? 1.0 : _opacityAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon with circular shadow
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: widget.isSelected
                          ? [
                        BoxShadow(
                          color: selectedColor.withOpacity(0.25),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ]
                          : null,
                    ),
                    child: Center(
                      child: _buildIcon(
                        widget.item.svgIcon,
                        widget.item.fallbackIcon,
                        widget.isSelected ? selectedColor : unselectedColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Label with animation
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: widget.isSelected ? selectedColor : unselectedColor,
                      letterSpacing: 0.1,
                      height: 1.2,
                    ),
                    child: Text(
                      widget.item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(String svgPath, IconData fallbackIcon, Color color) {
    return FutureBuilder<bool>(
      future: _checkAssetExists(svgPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: 24,
            height: 24,
            child: Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return SvgPicture.asset(
            svgPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
          );
        }

        // Fallback to material icon
        return Icon(
          fallbackIcon,
          size: 24,
          color: color,
        );
      },
    );
  }

  Future<bool> _checkAssetExists(String path) async {
    try {
      await DefaultAssetBundle.of(context).load(path);
      return true;
    } catch (e) {
      debugPrint('Asset not found: $path');
      return false;
    }
  }
}

/// Navigation item data model
class NavItemModel {
  final String svgIcon;
  final IconData fallbackIcon;
  final String label;
  final String route;

  const NavItemModel({
    required this.svgIcon,
    required this.fallbackIcon,
    required this.label,
    required this.route,
  });
}

/// Navigation controller with improved state management
class NavController extends GetxController {
  static const String updateId = 'navbar';

  // Reactive selected index - STARTS AT 0 (HOME) BY DEFAULT
  final RxInt selectedIndex = 0.obs;

  // Route history for back navigation handling
  final List<String> _routeHistory = [];

  // Navigation items configuration
  final List<NavItemModel> navItems = const [
    NavItemModel(
      svgIcon: "assets/icons/home.svg",
      fallbackIcon: Icons.home_outlined,
      label: "Home",
      route: AppRoutes.home, // INDEX 0 - HOME
    ),
    NavItemModel(
      svgIcon: "assets/icons/ask.svg",
      fallbackIcon: Icons.book_outlined,
      label: "Ask",
      route: AppRoutes.muslimAI, // INDEX 1 - ASK/MUSLIM AI
    ),
    NavItemModel(
      svgIcon: "assets/icons/shorts.svg",
      fallbackIcon: Icons.play_circle_outline,
      label: "Shorts",
      route: AppRoutes.shorts, // INDEX 2 - SHORTS
    ),
    NavItemModel(
      svgIcon: "assets/icons/stories.svg",
      fallbackIcon: Icons.video_library_outlined,
      label: "Stories",
      route: AppRoutes.stories, // INDEX 3 - STORIES
    ),
    NavItemModel(
      svgIcon: "assets/icons/quran.svg",
      fallbackIcon: Icons.menu_book_outlined,
      label: "Qur'an",
      route: AppRoutes.quranScreen, // INDEX 4 - QURAN
    ),
  ];

  // Route to index mapping for efficient lookup
  late final Map<String, int> _routeToIndex = {
    for (var i = 0; i < navItems.length; i++) navItems[i].route: i,
  };

  @override
  void onInit() {
    super.onInit();
    // INITIALIZE: Set home as default and update from current route
    _initializeNavbar();
  }

  /// Initialize navbar - ensures home is selected on app start
  void _initializeNavbar() {
    // Get current route
    final currentRoute = Get.currentRoute;

    // ✅ FORCE HOME TO BE ACTIVE ON APP START
    // Check if app just opened (route is '/' or initial)
    if (currentRoute == '/' || currentRoute.isEmpty) {
      selectedIndex.value = 0; // HOME
      _addToHistory(navItems[0].route);
      debugPrint('✅ App opened - Home selected (index: 0)');
      update([updateId]);
      return;
    }

    // If current route is in navbar items, select it
    if (_routeToIndex.containsKey(currentRoute)) {
      final index = _routeToIndex[currentRoute]!;

      // ✅ OVERRIDE: If route is home, always set to index 0
      if (currentRoute == AppRoutes.home) {
        selectedIndex.value = 0;
        _addToHistory(currentRoute);
        debugPrint('✅ Initialized navbar to HOME (index: 0)');
      } else {
        selectedIndex.value = index;
        _addToHistory(currentRoute);
        debugPrint('✅ Initialized navbar to index: $index for route: $currentRoute');
      }
    } else {
      // Otherwise default to home (index 0)
      selectedIndex.value = 0;
      _addToHistory(navItems[0].route);
      debugPrint('✅ Initialized navbar to HOME (index: 0)');
    }

    update([updateId]);
  }

  /// Navigate to specific tab
  void navigateTo(int index, String route) {
    // Prevent navigation if already on the route
    if (Get.currentRoute == route) {
      debugPrint('Already on route: $route');
      return;
    }

    // Validate index
    if (index < 0 || index >= navItems.length) {
      debugPrint('Invalid navigation index: $index');
      return;
    }

    // Update selected index
    selectedIndex.value = index;
    update([updateId]);

    // Navigate and clear stack
    Get.offAllNamed(route);

    // Save to history
    _addToHistory(route);

    debugPrint('✅ Navigated to: $route (index: $index)');
  }

  /// Update navbar state based on current route
  void updateFromCurrentRoute() {
    final currentRoute = Get.currentRoute;

    // ✅ FIX: Check if route is home route
    if (currentRoute == AppRoutes.home) {
      if (selectedIndex.value != 0) {
        selectedIndex.value = 0;
        update([updateId]);
        debugPrint('✅ Updated navbar to HOME (index: 0)');
      }
      _addToHistory(currentRoute);
      return;
    }

    if (_routeToIndex.containsKey(currentRoute)) {
      final index = _routeToIndex[currentRoute]!;

      if (selectedIndex.value != index) {
        selectedIndex.value = index;
        update([updateId]);
        debugPrint('✅ Updated navbar to index: $index for route: $currentRoute');
      }

      _addToHistory(currentRoute);
    } else if (_routeHistory.isNotEmpty) {
      // If on a non-navbar route, maintain last navbar selection
      final lastNavbarRoute = _routeHistory.last;
      final index = _routeToIndex[lastNavbarRoute]!;

      if (selectedIndex.value != index) {
        selectedIndex.value = index;
        update([updateId]);
        debugPrint('✅ Maintained navbar state for non-navbar route');
      }
    }
  }

  /// Add route to history (maintaining only navbar routes)
  void _addToHistory(String route) {
    if (_routeToIndex.containsKey(route)) {
      if (_routeHistory.isEmpty || _routeHistory.last != route) {
        _routeHistory.clear();
        _routeHistory.add(route);
      }
    }
  }

  /// Get current selected route
  String get currentRoute => navItems[selectedIndex.value].route;

  /// Check if a specific index is selected
  bool isSelected(int index) => selectedIndex.value == index;

  /// Reset to home
  void resetToHome() {
    navigateTo(0, navItems[0].route);
  }

  @override
  void onClose() {
    _routeHistory.clear();
    super.onClose();
  }
}