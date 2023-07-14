class Endpoint {
  Endpoint._();
  static const String baseUrl =
      'http://117.200.73.2:7075/lawyer/public/api/';

  // RegisterUser
  static const String registerUser =
      '${baseUrl}registerLawyer';

  static const String getAllCountries =
      '${baseUrl}getAllCountries';

  static const String getAllStateList =
      '${baseUrl}getStatesByCountry/1';

  static const String getCaseRequestList =
      '${baseUrl}listQuotesForLawyer';

  static const String getCaseList =
      '${baseUrl}getLawyerCaseList';

  static const String getClientList =
      '${baseUrl}getLawyerClientList';

  static const String saveQuotation =
      '${baseUrl}saveQuotes';

  static const String getQuotationListForLawyer =
      '${baseUrl}getQuotationListForLawyer';

  static const String getQuotationDtlsForLawyer =
      '${baseUrl}getQuotationDtlsForLawyer';

  static const String getRequestDtlsForLawyer =
      '${baseUrl}getQuoteDtls';

  static const String getCaseDtlsForLawyer =
      '${baseUrl}getCaseDetails';

  static const String getLawyerDtls =
      '${baseUrl}getLawyerDtls';

  static const String uploadLawyerProfile =
      '${baseUrl}updateLawyer';

  static const String uploadLawyerProfilePic =
      '${baseUrl}updateLawyerProfilePic';

}