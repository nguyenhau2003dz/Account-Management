//
//  ABDeeplinkEvent.h
//  AirBridge
//
//  Created by WOF on 06/03/2019.
//  Copyright © 2019 ab180. All rights reserved.
//

#import <AirBridge/ABEvent.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABDeeplinkEvent : ABEvent

- (instancetype) init;
- (void) setIsUniversalTrackingLink:(NSNumber*)enable;
- (void) setDeeplink:(NSString*)deeplink;
- (void)setReferrerURL:(NSString*)referrerURLString;

@end

NS_ASSUME_NONNULL_END
