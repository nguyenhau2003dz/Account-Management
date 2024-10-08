#import "ZoomableView.h"

@implementation ZoomableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *img = [UIImage imageNamed:@"logoo"];
    self.imageView.image = img;

    // Thiết lập trạng thái mặc định
    self.isZoomed = NO;
    
    // Thêm tap gesture cho imageView
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleZoom)];
    [self addGestureRecognizer:tapGesture];
    
    // Cho phép tương tác với view
    self.userInteractionEnabled = YES;
    
    
}

// Hàm xử lý phóng to/thu nhỏ ảnh
- (void)toggleZoom {
    [UIView animateWithDuration:0.3 animations:^{
        if (self.isZoomed) {
            // Thu nhỏ lại kích thước ban đầu
            self.imageView.transform = CGAffineTransformIdentity;
            
        } else {
            // Phóng to gấp đôi
            self.imageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
        }
    }];
    
    // Đổi trạng thái phóng to/thu nhỏ
    self.isZoomed = !self.isZoomed;
}

@end
