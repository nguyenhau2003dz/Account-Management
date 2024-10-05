#import <Foundation/Foundation.h>

@interface AccountModel : NSObject

@property (nonatomic, strong) NSString *fullname;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *imageAccount;
@property (nonatomic, strong) NSString *_id;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
