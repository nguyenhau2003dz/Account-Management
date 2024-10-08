#import <UIKit/UIKit.h>

@interface ZoomableView : UIView

@property (nonatomic) BOOL isZoomed;  // Trạng thái phóng to/thu nhỏ
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


- (void)toggleZoom;
@end
