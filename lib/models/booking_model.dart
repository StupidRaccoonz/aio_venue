class BookingModel {
  final String sportName, groundName, timing, bookedBy;
  final List<Addon> addons;

  BookingModel({required this.sportName, required this.groundName, required this.timing, required this.bookedBy, required this.addons});
}

class Addon {
  final String name, price, quantity;

  Addon({required this.name, required this.price, required this.quantity});
}
