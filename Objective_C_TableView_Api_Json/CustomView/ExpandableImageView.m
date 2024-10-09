#import "ExpandableImageView.h"

@interface ExpandableImageView ()

@property (nonatomic, assign) BOOL isExpanded;

@end

@implementation ExpandableImageView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.isExpanded = NO;

    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.clipsToBounds = YES;

    // Thêm UITapGestureRecognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.imageView addGestureRecognizer:tapGesture];

    [self addSubview:self.imageView];
}

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    self.isExpanded = !self.isExpanded;

    [UIView animateWithDuration:0.3 animations:^{
        if (self.isExpanded) {
            self.imageView.transform = CGAffineTransformMakeScale(2.0, 2.0); // Mở rộng gấp đôi
        } else {
            self.imageView.transform = CGAffineTransformIdentity; // Trở về kích thước ban đầu
        }
    }];
}

@end
