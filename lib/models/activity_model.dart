class ActivityModel {
  final String team1, team2, matchName, date, time, amount, stadiumName, registrationFee;
  final bool venueChallenge;

  ActivityModel(
      {required this.team1,
      required this.team2,
      required this.matchName,
      required this.date,
      required this.time,
      required this.amount,
      required this.stadiumName,
      required this.registrationFee,
      required this.venueChallenge});
}
