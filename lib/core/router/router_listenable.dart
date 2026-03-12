import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gas_app/features/auth/presentation/notifiers/auth_notifier.dart';

final routerListenableProvider = Provider((ref) => RouterListenable(ref));

class RouterListenable extends ChangeNotifier {
  final Ref _ref;
  RouterListenable(this._ref) {
    _ref.listen(authNotifierProvider.select((s) => s.status), (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }
}
