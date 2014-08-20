#import <Cordova/CDV.h>
#import <FacebookSDK/FacebookSDK.h>

@interface Conversion : CDVPlugin
- (void)setAppID:(CDVInvokedUrlCommand*)command;
- (void)activateApp:(CDVInvokedUrlCommand*)command;
- (void)logCustomEvent:(CDVInvokedUrlCommand *)command;
- (void)registrationComplete:(CDVInvokedUrlCommand *)command;
@end
