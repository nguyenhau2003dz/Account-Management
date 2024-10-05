#import "AccountModel.h"

@implementation AccountModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _fullname = dictionary[@"fullname"];
        _username = dictionary[@"username"];
        _password = dictionary[@"password"];
        _imageAccount = dictionary[@"image_account"];
        __id = dictionary[@"_id"];
    }
    return self;
}

@end
