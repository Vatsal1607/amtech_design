enum DetailsType {
  details,
  subscription,
}

enum AddressType {
  Home,
  Work,
  Other,
}

enum HomeAddressType {
  local,
  remote,
}

// extension DetailsTypeExtension on DetailsType {
//   String get value {
//     switch (this) {
//       case DetailsType.details:
//         return 'details';
//       case DetailsType.subscription:
//         return 'subscription';
//     }
//   }
// }
