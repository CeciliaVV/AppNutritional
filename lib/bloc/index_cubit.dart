import 'package:flutter_bloc/flutter_bloc.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(IndexState(0));

  int changePage(currentIndex) {
    if (currentIndex == 0) {
      emit(IndexState(0));
      return 0;
    }

    if (currentIndex == 1) {
      emit(IndexState(1));
      return 1;
    }
    if (currentIndex == 2) {
      emit(IndexState(2));
      return 2;
    }
    if (currentIndex == 3) {
      emit(IndexState(3));
      return 3;
    }
    return 0;
  }
}

class IndexState {
  int indexValue;
  IndexState(this.indexValue);
}
