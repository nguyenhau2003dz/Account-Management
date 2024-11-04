

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum : int {
    DevBaseURL,
    ProductBaseURL,
    BetaBaseURL,
} BaseURL;
@interface ObjectSetting : NSObject

@property (nonatomic, setter=setManuallyCallAuthorizeMethod:) BOOL manuallyCallAuthorizeMethod;
@property (nonatomic, strong) NSString *baseURLString;
@property (nonatomic, strong) NSString *baseURLWebSDKv2;
//Set MainWindow for SDK as game Window
@property (nonatomic, strong) UIWindow *mainWindow;

@property (nonatomic, strong) NSString *clientName;
@property (nonatomic, strong) NSString *gameId;

+ (instancetype)defaultSettings;
+ (BOOL)isLandscape ;
+ (NSString*)getAppName;
+ (UIColor *)ScorpionManagerSetNavigationColor;
+ (CGRect)SetCurrentGameBound;
+ (NSString*)md5FromString:(NSString*)string;
+ (void)setBaseURL:(BaseURL)url;
@end
