#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadImageFromHau : NSObject

+ (instancetype)sharedInstance;

// Phương thức để tải ảnh từ URL
- (void)loadImageWithURL:(NSURL *)url intoImageView:(UIImageView *)imageView placeholderImage:(UIImage *)placeholder;

@end

NS_ASSUME_NONNULL_END
