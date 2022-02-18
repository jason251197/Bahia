part of '../address_card.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class Candidates {
  Candidates({
    this.candidates,
    this.status,
  });

  List<Result> candidates;
  String status;

  factory Candidates.fromJson(Map<String, dynamic> json) => Candidates(
        candidates: json["candidates"] == null
            ? null
            : List<Result>.from(
                json["candidates"].map((x) => Result.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "candidates": candidates == null
            ? null
            : List<dynamic>.from(candidates.map((x) => x.toJson())),
        "status": status == null ? null : status,
      };
}
