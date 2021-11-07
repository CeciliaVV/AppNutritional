import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(InitialStateHistory());
  final List<String> miHistorial = [];
  Future eraseHistory(int index) async {
    emit(EraseState());
    List<String> miHistorial = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    miHistorial = (prefs.getStringList('_keyHistorial') ?? []);
    miHistorial.removeAt(miHistorial.length - index - 1);
    prefs.setStringList('_keyHistorial', miHistorial);
  }
}

abstract class HistoryState {}

class InitialStateHistory extends HistoryState {}

class EraseState extends HistoryState {}

class ErrorState extends HistoryState {
  final String message;
  ErrorState(this.message);
}
