// class CaseRequestListReqModel{
//   String ? token;
//   CaseRequestListReqModel({
//     this.token,
// });
//   Map<String,dynamic>toJson(){
//     Map<String,dynamic> data={};
//     data["token"];
//     return data;
//   }
// }
//
// class CaseRequestListResModel{
//   List<CaseRequestD> ? caseReqListData;
//
//   CaseRequestListResModel({
// this.caseReqListData,
// });
//   CaseRequestListResModel.fromJson(Map<String,dynamic>json){
//     if (json["customer_order_details"] != null) {
//       caseReqListData = [];
//       json["customer_order_details"].forEach((v) {
//         caseReqListData!.add(CustomerOrderDetail.fromJson(v));
//       });
//     }
//   }
// }