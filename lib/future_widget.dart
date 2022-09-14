import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FutureWidget<Tx> extends ConsumerStatefulWidget {
  final Future<Tx> future;
  final StateNotifierProvider<FutureNotifier<Tx>, AsyncValue<Tx>> iapProvider =
      StateNotifierProvider<FutureNotifier<Tx>, AsyncValue<Tx>>((ref) {
    return FutureNotifier<Tx>();
  });
  FutureWidget(this.future, {Key? key}) : super(key: key);

  @override
  ConsumerState<FutureWidget> createState() => _FutureWidgetState();
}

class _FutureWidgetState<Tx> extends ConsumerState<FutureWidget> {
  @override
  void initState() {
    ref.read(widget.iapProvider.notifier).doWork(widget.future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var iapWatch = ref.watch(widget.iapProvider);
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

class FutureNotifier<T> extends StateNotifier<AsyncValue<T>> {
  FutureNotifier() : super(const AsyncValue.loading());
  doWork(Future<T> future) async {
    T ret = await future;
    state = AsyncValue.data(ret);
  }
}
