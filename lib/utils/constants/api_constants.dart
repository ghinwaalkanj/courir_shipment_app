
/* -- LIST OF Constants used in APIs -- */

const String DelieveryAPIKey = "https://api.wasenahon.com/Kwickly/delivery/";

// Authentication Endpoints
const String LoginEndpoint = "${DelieveryAPIKey}auth/login.php";
const String VerifyEndpoint = "${DelieveryAPIKey}auth/verify.php";
const String PersonalInfoEndpoint = "${DelieveryAPIKey}auth/personal_info.php";
const String IDUploadEndpoint = "${DelieveryAPIKey}auth/ID_Upload.php";

// Shipment Endpoints
const String AddShipmentEndpoint = "${DelieveryAPIKey}shipments/add.php";
const String ViewShipmentByIdEndpoint = "${DelieveryAPIKey}shipments/viewById.php";
const String ViewShipmentEndpoint = "${DelieveryAPIKey}shipments/view.php";
const String calculateShippingFeeEndpoint = "${DelieveryAPIKey}shipments/calculateShippingFee.php";
const String SearchShipmenEndpoint = "${DelieveryAPIKey}shipments/search.php";
const String CancelShipmenEndpoint = "${DelieveryAPIKey}shipments/cancel_shipment.php";


// Profile Endpoints
const String ProfileEndpoint = "${DelieveryAPIKey}profile.php";
const String EditProfileEndpoint = "${DelieveryAPIKey}edit_profile.php";



// Notifications  Endpoints
const String NotificationsEndpoint = "${DelieveryAPIKey}get_notifications.php";

// Home Endpoints
const String HomeEndpoint = "${DelieveryAPIKey}home.php";

// Address  Endpoints

const String GetCitiesEndpoint = "${DelieveryAPIKey}address/get_cities.php";
const String AddAddressEndpoint = "${DelieveryAPIKey}address/add.php";
const String ViewAddressEndpoint = "${DelieveryAPIKey}address/view.php";
const String SetDefaultAddressEndpoint = "${DelieveryAPIKey}address/set_default_address.php";

