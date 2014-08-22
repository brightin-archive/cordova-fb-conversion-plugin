package com.brightin.conversion;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.os.Bundle;
import java.util.Iterator;
import android.util.Log;

import com.facebook.AppEventsLogger;
import com.facebook.AppEventsConstants;
import com.facebook.FacebookException;

public class Conversion extends CordovaPlugin {
  private final String TAG = "Conversion";

  private String applicationId = null;
  private AppEventsLogger logger = null;
  private Context context = null;

  @Override
  public boolean execute(String action, JSONArray args,
    final CallbackContext callbackContext) throws JSONException {

    if (action.equals("setAppID")) {
      if (args.length() == 0) {
        // Not enough parameters
        callbackContext.error("Invalid arguments");
        return true;
      }

      applicationId = args.getString(0);

      context = this.cordova.getActivity().getApplicationContext();
      logger = AppEventsLogger.newLogger(context, applicationId);
      callbackContext.success();
      return true;
    } else if (action.equals("activateApp")) {
      if (logger == null) {
        callbackContext.error("setAppID must be called first before activateApp is used");
        return true;
      }

      com.facebook.AppEventsLogger.activateApp(context, applicationId);

      callbackContext.success();
      return true;
    } else if (action.equals("logCustomEvent")) {
      if (logger == null) {
        callbackContext.error("setAppID must be called first before logCustomEvent is used");
        return true;
      }

      if (args.length() == 0) {
        // Not enough parameters
        callbackContext.error("Invalid arguments");
        return true;
      } else {
        this.logEvent(args.getString(0), null);
        callbackContext.success();
        return true;
      }
    } else if (action.equals("registrationComplete")) {
      if (logger == null) {
        callbackContext.error("setAppID must be called first before registrationComplete is used");
        return true;
      }

      if (args.length() == 0) {
        // Not enough parameters
        callbackContext.error("Invalid arguments");
        return true;
      } else {
        Bundle params = new Bundle();
        params.putString(AppEventsConstants.EVENT_PARAM_REGISTRATION_METHOD, args.getString(0));
        this.logEvent(AppEventsConstants.EVENT_NAME_COMPLETED_REGISTRATION, params);
        callbackContext.success();
        return true;
      }
    }

    return false;
  }

  private boolean logEvent(String eventName, Bundle parameters) throws JSONException {
    if (parameters == null) {
      logger.logEvent(eventName);
    } else {
      logger.logEvent(eventName, parameters);
    }
    return true;
  }
}
