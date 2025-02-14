enum DetailsType {
  details,
  subscription,
}

extension DetailsTypeExtension on DetailsType {
  String get value {
    switch (this) {
      case DetailsType.details:
        return 'details';
      case DetailsType.subscription:
        return 'subscription';
    }
  }
}
