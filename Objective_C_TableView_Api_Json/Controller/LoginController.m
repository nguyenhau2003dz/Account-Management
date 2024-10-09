//
//  LoginController.m
//  Objective_C_TableView_Api_Json
//
//  Created by Nguyễn Đức Hậu on 09/10/2024.
//

#import "LoginController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ViewController.h"
@interface LoginController ()
@property (nonatomic, strong) FBSDKLoginManager *fbloginmanager;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fbloginmanager = [[FBSDKLoginManager alloc] init];
}
- (IBAction)btnLogin:(id)sender {
    [self login];
}

- (void)login {
    [self.fbloginmanager logInWithPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *err) {
        if (err == nil) {
            NSLog(@"Đăng Nhập Thành Công");
            
            // Khởi tạo ViewController2 từ storyboard
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginSuccess"];
            
            // Đẩy ViewController vào NavigationController
            [self.navigationController pushViewController:vc animated:YES];

        } else {
            NSLog(@"Đăng Nhập Thất Bại");
        }
    }];
}
@end
