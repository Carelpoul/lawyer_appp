class GetStateListResModel {
  String? errorCode;
  String? status;
  List<StateData>? stateData;

  GetStateListResModel({
    this.errorCode,
    this.status,
    this.stateData,
  });

  GetStateListResModel.fromJson(Map<String, dynamic> json) {
    status = json["STATUS"];
    errorCode = json["ERROR_CODE"];
    if (json["DATA"] != null) {
      stateData = <StateData>[];
      json["DATA"].forEach((v) {
        stateData!.add(StateData.fromJson(v));
      });
    }
  }
}

class StateData {
  int? id;
  String? stateName;

  StateData({
    this.id,
    this.stateName,
  });

  StateData.fromJson(Map<String, dynamic> json) {
    id = json["pk_cmn_state_id"];
    stateName = json["cmn_state_name"];
  }
}
