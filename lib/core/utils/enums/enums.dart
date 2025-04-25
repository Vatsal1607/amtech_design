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

enum PaymentType {
  order,
  recharge,
  subscription,
}

enum SelectedPaymentMethod {
  perks,
  upi,
}

//* Socket event
enum OrderStatus {
  placed,
  confirmed,
  preparing,
  acceptedByDeliveryBoy,
  prepared,
  outForDelivery,
  delivered,
  rejected,
}

extension OrderStatusExtension on OrderStatus {
  String get value {
    switch (this) {
      case OrderStatus.placed:
        return "Placed";
      case OrderStatus.confirmed:
        return "Confirmed";
      case OrderStatus.preparing:
        return "Preparing";
      case OrderStatus.acceptedByDeliveryBoy:
        return "Accepted by DeliveryBoy";
      case OrderStatus.prepared:
        return "Prepared";
      case OrderStatus.outForDelivery:
        return "Out for Delivery";
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.rejected:
        return "Rejected";
    }
  }

  static OrderStatus fromString(String status) {
    switch (status) {
      case "Placed":
        return OrderStatus.placed;
      case "Confirmed":
        return OrderStatus.confirmed;
      case "Preparing":
        return OrderStatus.preparing;
      case "Accepted by DeliveryBoy":
        return OrderStatus.acceptedByDeliveryBoy;
      case "Prepared":
        return OrderStatus.prepared;
      case "Out for Delivery":
        return OrderStatus.outForDelivery;
      case "Delivered":
        return OrderStatus.delivered;
      case "Rejected":
        return OrderStatus.rejected;
      default:
        return OrderStatus.placed; // fallback/default
    }
  }
}

//* Uses example
// final statusFromApi = "Prepared";
// final orderStatusEnum = OrderStatusExtension.fromString(statusFromApi);

// print(orderStatusEnum); // OrderStatus.prepared
// print(orderStatusEnum.value); // Prepared
