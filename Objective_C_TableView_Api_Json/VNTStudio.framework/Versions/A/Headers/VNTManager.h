
// Version_SDK 2.2
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ObjectUser.h"
#import "ObjectSetting.h"
@protocol VNTStudioManagerDelegate <NSObject,UIApplicationDelegate>
@required
@optional
// Returns   user infor  when logging success;
- (void)callBackLoginSDK:(ObjectUser *)user;
// Returns   user infor  when logout success;
- (void)callBackLogoutSDK: (ObjectUser *)user;
// Returns   when buy in-app purchases  success;
- (void)callBackDidInPurchase:(NSString *)orderID;

@end
@interface VNTManager : NSObject<VNTStudioManagerDelegate>
@property (nonatomic, assign) id<VNTStudioManagerDelegate> delegate;

+ (instancetype)initWithGameDelegate:(id<VNTStudioManagerDelegate>)delegate
                         application:(UIApplication *)application
                     isLoginManually:(BOOL)manually;

#pragma mark - LOGIN
    // Call Login SDK  ->  ( Show Screen Login )
+ (void)loginSDKWithBlock:(void (^)(ObjectUser *user, NSError *error))completionBlock;
// Call Logout SDK  ->  ( Show Screen Login )
+ (void) CallLogoutSDK;


#pragma mark - IAP
+ (void)showPayCenter:(NSString*)plf_product_id;

+ (void)closePayCenter;	

#pragma mark - PushNotice
//
+ (void)postDeviceTokenToServer:(NSData *)deviceToken;


#pragma mark - inheritance
+ (void)handleRemoteNotification:(NSDictionary *)notificationDictionary application:(UIApplication*)application;

+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation;

// Reports app open from deep link for iOS 10
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(NSDictionary *) options;

// Reports app open from a Universal Link for iOS 9 or above
+ (BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *_Nullable))restorationHandler;

+ (BOOL)handleOpenURL:(NSURL *)url;

+ (void)handleWillTerminate;

+ (void)handleDidBecomeActive;

+ (void)handleDidEnterBackground;

+ (void)handleDidEnterForeground;

+(void)showNotifiConnectAccount;

//+(void)setupTracking;


#pragma mark - tracking

+(void)sendTrackingLogAddToCart:(nullable NSString*)eventName withValue:(nullable NSString*)coin
                       inScreen:(nullable NSString*)screen;
+(void)sendTrackingLogPaySuccess:(nullable NSString*)eventName withValue:(nullable NSString*)coin
                       inScreen:(nullable NSString*)screen;

+(void)sendGameTrackingLogWithEvent:(nullable NSString*)eventName category:(nullable NSString*)category params:(nullable NSString*)params;

/**
 * @brief set AreaID and RoleID, Area name and Role name for user.
 * @discussion these values must be set after game choose server & character <if need>
 * @param serverId area identifier (areaId). Require
 * @param charId role identifier (roleId). Require
 * @param serverName area name (areaName). Optional, default value is @"".
 * @param charName role name (roleName). Require
 * @param charLevel role level (character level). Require
 * @note This method is REQUIRE and should be revoked right after game has full these info.
 */
//wtf
//Call Set Info Character When login Success
+ (void)setGameServerID:(NSString *)serverId
         gameServerName:(NSString *)serverName
            characterID:(NSString *)charId
          characterName:(NSString *)charName
         characterLevel:(NSString *)charLevel;


//Call Set Info Character When before call payment
+ (void)setGameServerIDBeforePayment:(NSString *)serverId
         gameServerName:(NSString *)serverName
            characterID:(NSString *)charId
          characterName:(NSString *)charName
         characterLevel:(NSString *)charLevel;

@end
