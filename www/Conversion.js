var Conversion = {};

Conversion.setAppID = function(app_id) {
  window.cordova.exec(function (response) {}, function() { console.log(arguments); }, "Conversion", "setAppID", [app_id]);
}

Conversion.activateApp = function() {
  window.cordova.exec(function (response) {}, function() { console.log(arguments); }, "Conversion", "activateApp", []);
}

Conversion.logCustomEvent = function(event_name) {
  window.cordova.exec(function (response) {}, function() { console.log(arguments); }, "Conversion", "logCustomEvent", [event_name]);
}

Conversion.registrationComplete = function(registration_method) {
  window.cordova.exec(function (response) {}, function() { console.log(arguments); }, "Conversion", "registrationComplete", [registration_method]);
}

module.exports = Conversion;
