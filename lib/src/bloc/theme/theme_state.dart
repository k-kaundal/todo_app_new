part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}
class DarkThemeState extends ThemeState{
  bool isDarkMode = true;
  DarkThemeState(this.isDarkMode);
  @override
  List<Object?> get props => [isDarkMode];

}
class LightThemeState extends ThemeState{
  bool isLightMode = true;
  LightThemeState(this.isLightMode);
  @override
  List<Object?> get props => [isLightMode];
}
