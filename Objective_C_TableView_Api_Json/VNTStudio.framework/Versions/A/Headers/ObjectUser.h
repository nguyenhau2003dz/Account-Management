

#import <Foundation/Foundation.h>

@interface ObjectUser : NSObject
@property (nonatomic,strong) NSString *serverID;
@property (nonatomic,strong) NSString *characterID;
@property (nonatomic,strong) NSString *serverName;
@property (nonatomic,strong) NSString *characterName;
@property (nonatomic,strong) NSString *characterLevel;
@property (nonatomic,strong) NSString *timeSaveCharater;

    // Info Account
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userEmail;
@property (nonatomic,strong) NSString *avatarImgLink;
@property (nonatomic,strong) NSString *playGameLink;

@property (nonatomic,strong) NSString *accessToken;
    // Use userId for Character in Game
@property (nonatomic,strong) NSString *accountId;

@property (nonatomic,strong) NSString *type_user;

@property (nonatomic,strong) NSString *puId;

+ (ObjectUser *)currentUser;
- (void)updateInfoWithData:(NSDictionary *)userInfo;
- (void)clearData;

@end


