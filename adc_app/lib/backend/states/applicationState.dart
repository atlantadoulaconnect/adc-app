import 'common.dart';

part 'applicationState.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class ApplicationState {
  final String status;
  final Map<String, bool> pages; // <Name of page, isCompleted>
  final String type; // A D C or none (if none send them to the app type)

  ApplicationState({this.status, this.pages, this.type}) {
    print("ApplicationState\nstatus: $status\n\t${type}");
  }

  static ApplicationState initialState() {
    return ApplicationState(status: null, pages: null, type: "none");
  }

  ApplicationState copy({String status, Map<String, bool> pages, String type}) {
    return ApplicationState(
        status: status ?? this.status,
        pages: pages ?? this.pages,
        type: type ?? this.type);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ApplicationState &&
            runtimeType == other.runtimeType &&
            status == other.status &&
            mapEquals(pages, other.pages) &&
            type == other.type;
  }

  @override
  int get hashCode {
    return status.hashCode ^ pages.hashCode ^ type.hashCode;
  }

  @override
  String toString() {
    return "ApplicationState: status: $status\ttype: $type";
  }

  factory ApplicationState.fromJson(Map<String, dynamic> json) =>
      _$ApplicationStateFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationStateToJson(this);
}
