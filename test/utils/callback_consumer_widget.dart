part of 'utils.dart';

typedef ConsumerCallBack = void Function(BuildContext context, WidgetRef ref);

class CallbackConsumerWidget extends ConsumerStatefulWidget {
  const CallbackConsumerWidget({
    required this.child,
    this.initState,
    this.didChangeDependencies,
    this.dispose,
    this.didUpdateWidget,
    this.reassemble,
    super.key,
  });

  final Widget child;
  final ConsumerCallBack? initState;
  final ConsumerCallBack? didChangeDependencies;
  final ConsumerCallBack? dispose;
  final void Function(
    BuildContext context,
    WidgetRef ref,
    CallbackConsumerWidget oldWidget,
  )? didUpdateWidget;
  final void Function(BuildContext context, WidgetRef ref)? reassemble;

  @override
  // ignore: library_private_types_in_public_api
  _CallbackConsumerWidgetState createState() => _CallbackConsumerWidgetState();
}

class _CallbackConsumerWidgetState extends ConsumerState<CallbackConsumerWidget> {
  @override
  void initState() {
    super.initState();
    widget.initState?.call(context, ref);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call(context, ref);
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose?.call(context, ref);
  }

  @override
  void reassemble() {
    super.reassemble();
    widget.reassemble?.call(context, ref);
  }

  @override
  void didUpdateWidget(covariant CallbackConsumerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.didUpdateWidget?.call(context, ref, oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
