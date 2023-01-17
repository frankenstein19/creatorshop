import 'package:flex_color_scheme/flex_color_scheme.dart';

/// To change theme you need to visit flex playground where you can change theme.

/// This light theme data
final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.blue,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarOpacity: 0.95,
  tabBarStyle:  FlexTabBarStyle.forBackground,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
    navigationBarBackgroundSchemeColor: SchemeColor.primary,
  ),
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
// To use the playground font, add GoogleFonts package and uncomment
// fontFamily: GoogleFonts.notoSans().fontFamily,
);

/// This dark theme data
final darkTheme = FlexThemeData.dark(
  colors: FlexColor.schemes[FlexScheme.blue]!
      .light.defaultError.toDark(10, true),
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 15,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  tabBarStyle:  FlexTabBarStyle.forBackground,
  swapColors: true,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 30,
    navigationBarBackgroundSchemeColor: SchemeColor.primary,
  ),
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
// To use the playground font, add GoogleFonts package and uncomment
// fontFamily: GoogleFonts.notoSans().fontFamily,
);
