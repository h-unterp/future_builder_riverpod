import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef Thing<Tx> = Tx;

class FutureWidget<Tx> extends ConsumerStatefulWidget {
  const FutureWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<FutureWidget> createState() => _FutureWidgetState();
}

class _FutureWidgetState<Tx> extends ConsumerState<FutureWidget> {
  final iapProvider =
      StateNotifierProvider<IAPNotifier<Tx>, AsyncValue<Tx>>((ref) {
    return IAPNotifier();
  });

  @override
  Widget build(BuildContext context) {
    AsyncValue<Tx> iapWatch = ref.watch(iapProvider);
    bool isLoading = iapWatch is AsyncLoading<void>;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text('Hello World'),
      );
    }
  }
}

abstract class IAPNotifier<T> extends StateNotifier<AsyncValue<T>> {
  IAPNotifier() : super(const AsyncValue.loading());
  T doWork();
}
