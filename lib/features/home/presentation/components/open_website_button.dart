part of 'articles_components.dart';

class OpenWebsiteButton extends ConsumerWidget {
  const OpenWebsiteButton({required this.url, super.key});

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.isLoading(openWebsiteStateProvider);

    return CustomElevatedButton(
      onPressed: isLoading
          ? null
          : () {
              ref.read(openWebsiteEventProvider.notifier).update((_) => Some(Event.unique(url)));
            },
      buttonColor: Theme.of(context).appBarTheme.backgroundColor,
      borderRadius: BorderRadius.circular(ArticlesList.cardRadius),
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.buttonPaddingV16,
      ),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          tr(context).openWebsite.toUpperCase(),
          style: TextStyles.f18(context).copyWith(
            color: customColors(context).whiteColor,
          ),
        ),
      ),
    );
  }
}
