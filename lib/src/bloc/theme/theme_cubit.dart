import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  LightThemeState lightThemeState;
  ThemeCubit(this.lightThemeState) : super(lightThemeState);
  void toggleSwitch(bool value ){
    emit(value?DarkThemeState(value):LightThemeState(value));
  }
}
