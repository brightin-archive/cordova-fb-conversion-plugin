#import "Conversion.h"
#import <Cordova/CDV.h>

@implementation Conversion

- (void)setAppID:(CDVInvokedUrlCommand*)command
{
    NSString* app_id = [command.arguments objectAtIndex:0];
    if (app_id == nil) {
        CDVPluginResult* pluginResult;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"App ID not specified"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }

    [FBSettings setDefaultAppID:app_id];
    [FBSettings setLoggingBehavior:[NSSet setWithObjects:FBLoggingBehaviorAppEvents, nil]];
}

- (void)activateApp:(CDVInvokedUrlCommand*)command
{
    if ([FBSettings defaultAppID] == nil) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"App ID not set"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }

    NSLog(@"Submitting activateApp facebook event");
    [FBAppEvents activateApp];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)logCustomEvent:(CDVInvokedUrlCommand *)command
{
    if ([FBSettings defaultAppID] == nil) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"App ID not set"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }

    if ([command.arguments count] == 0) {
        // Not enough arguments
        CDVPluginResult *res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }
    [self.commandDelegate runInBackground:^{
        // For more verbose output on logging uncomment the following:
        // [FBSettings setLoggingBehavior:[NSSet setWithObject:FBLoggingBehaviorAppEvents]];
        NSString *eventName = [command.arguments objectAtIndex:0];
        CDVPluginResult *res;

        NSLog(@"Logging event: %@", eventName);

        if ([command.arguments count] == 1) {
            [FBAppEvents logEvent:eventName];
        }

        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
    }];
}

- (void)registrationComplete:(CDVInvokedUrlCommand *)command
{
    if ([command.arguments count] == 0) {
        // Not enough arguments
        CDVPluginResult *res = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid arguments"];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
        return;
    }

    [self.commandDelegate runInBackground:^{
        NSString *eventName = FBAppEventNameCompletedRegistration;
        NSString *registrationMethod = [command.arguments objectAtIndex:0];
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: registrationMethod, FBAppEventParameterNameRegistrationMethod, nil];
        CDVPluginResult *res;

        NSLog(@"Logging event: %@", eventName);

        [FBAppEvents logEvent:eventName parameters:params];

        res = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:res callbackId:command.callbackId];
    }];
}

@end
