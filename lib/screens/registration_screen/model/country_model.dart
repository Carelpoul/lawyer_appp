class GetCountryListResModel {
  String? errorCode;
  String? status;
  List<CountryData>? countryData;

  GetCountryListResModel({
    this.errorCode,
    this.status,
    this.countryData,
  });

  GetCountryListResModel.fromJson(Map<String, dynamic> json) {
    status = json["STATUS"];
    errorCode = json["ERROR_CODE"];
    if (json["DATA"] != null) {
      countryData = <CountryData>[];
      json["DATA"].forEach((v) {
        countryData!.add(CountryData.fromJson(v));
      });
    }
  }
}

class CountryData {
  int? id;
  String? countryName;

  CountryData({
    this.id,
    this.countryName,
  });

  CountryData.fromJson(Map<String, dynamic> json) {
    id = json["pk_country_id"];
    countryName = json["cmn_country_name"];
  }
}
