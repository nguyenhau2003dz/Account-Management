//
//  AppDelegate.m
//  Objective_C_TableView_Api_Json
//
//  Created by Nguyễn Đức Hậu on 03/10/2024.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GIDSignIn.h>
#import <AirBridge/AirBridge.h>
#import <AdSupport/AdSupport.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AirBridge setLogLevel:AB_LOG_ALL];
    [AirBridge getInstance:@"24f343627a254ab5a823d313f7d70399" appName:@"manageraccounts" withLaunchOptions:launchOptions];
    // Lấy iOS IDFA
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"IDFA: %@", idfa);
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [GIDSignIn.sharedInstance restorePreviousSignInWithCompletion:^(GIDGoogleUser * _Nullable user,
                                                                     NSError * _Nullable error) {
       if (error) {
         // Show the app's signed-out state.
       } else {
         // Show the app's signed-in state.
       }
     }];
     
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    [[FBSDKApplicationDelegate sharedInstance] application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    
    BOOL handled;
      handled = [GIDSignIn.sharedInstance handleURL:url];
      if (handled) {
        return YES;
      }
    
    return YES;
}




#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
   
}


@end
