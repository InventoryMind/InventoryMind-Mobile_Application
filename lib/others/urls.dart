final String domain = "https://inventory-mind.herokuapp.com";

// ---------------------------Common--------------------------------------------
final String loginURL = "$domain/auth/login";
final String logoutURL = "$domain/auth/logout";
// TODO: Add change password URL
final String changePwURL = "";

// ---------------------------Lecturer------------------------------------------
final String lecDashURL = "$domain/lecturer/getDashboardDataM";
final String getPendReqsURL = "$domain/lecturer/viewPendingRequest";
final String lecViewReqURL = "$domain/lecturer/viewRequest/"; // "/:reqId"
final String approveReqURL = "$domain/lecturer/approve/"; // "/:reqId"
final String rejectReqURL = "$domain/lecturer/reject/"; // "/:reqId"
final String getAppReqsURL = "$domain/lecturer/viewAcceptedRequests";
final String getRejReqsURL = "$domain/lecturer/viewRejectedRequests";
final String lecProfileURL = "$domain/lecturer/getUserDetails";

// ---------------------------Student-------------------------------------------
final String stuDashURL = "$domain/student/getDashboardDataM";

final String getAllReqsURL = "$domain/student/viewAllRequest";
final String stuViewReqURL = "$domain/student/viewRequest/"; // "/:reqId"
final String viewBorHistURL = "$domain/student/viewAllRequest";

final String stuProfileURL = "$domain/student/getUserDetails";
final String studentRegURL = "$domain/student/register";

// ---------------------------Technical Officer---------------------------------
final String toDashURL = "$domain/techOff/getDashboardDataM";
final String getEqTypesURL = "$domain/techOff/getEquipTypes";
final String addEqURL = "$domain/techOff/addEquipment";
final String removeEqURL = "$domain/techOff/removeEquipment/"; // "/:eqId"
final String getLabsURL = "$domain/techOff/getLabs";
final String transferEqURL = "$domain/techOff/transferEquipment";
final String getBorDetailsURL = "$domain/techOff/getBorrowDetails/";
final String acceptReturnURL = "$domain/techOff/acceptReturn";
final String mNotUsableURL = "$domain/techOff/markAsNotUsable/"; // "/:eqId"
final String mAvailableURL = "$domain/techOff/markAsAvailable/"; // "/:eqId"
final String toProfileURL = "$domain/techOff/getUserDetails";
