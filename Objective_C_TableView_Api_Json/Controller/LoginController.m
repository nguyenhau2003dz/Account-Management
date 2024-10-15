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
#import <GoogleSignIn/GoogleSignIn.h>
#import <AirBridge/AirBridge.h>

#import <AirBridge/ABUser.h>
#import <AirBridge/ABInAppEvent.h>
#import <AirBridge/ABCategory.h>

@interface LoginController ()
@property (nonatomic, strong) FBSDKLoginManager *fbloginmanager;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fbloginmanager = [[FBSDKLoginManager alloc] init];
}
- (IBAction)btnLogin2:(id)sender {
    
    [GIDSignIn.sharedInstance
          signInWithPresentingViewController:self
                                  completion:^(GIDSignInResult * _Nullable signInResult,
                                               NSError * _Nullable error) {
        if (error) {
          return;
        }
        
        if (signInResult) {
            NSLog(@"Đăng Nhập Thành Công Google");
            NSLog(@"User ID: %@", signInResult.user.userID);
            NSLog(@"User Name: %@", signInResult.user.profile.name);
            NSLog(@"User Email: %@", signInResult.user.profile.email);
            
            //Bắn even signIn in Airbridge
            ABUser* user = [[ABUser alloc] init];
            user.ID = signInResult.user.userID;
            user.email = signInResult.user.profile.email;
            user.alias = @{
                @"name": @"hau",
            };
            user.attributes = @{
                @"address": @"HCM",
            };
            [AirBridge.state setUser:user];
            ABInAppEvent* event = [[ABInAppEvent alloc] init];
            [event setCategory:ABCategory.signIn];
            [event send];
            
        
            [self moveToViewcontroller];
        } else {
            NSLog(@"signInResult is nil");
        }
        
               
    }];
}

- (IBAction)btnLogin:(id)sender {
    [self.fbloginmanager logInWithPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *err) {
        if (err == nil) {
            NSLog(@"Đăng Nhập Thành Công Facebook");
            [self moveToViewcontroller];
            
            [[FBSDKAppEvents shared] logEvent:@"userSignedIn"];

        } else {
            NSLog(@"Đăng Nhập Thất Bại");
        }
    }];
}

- (void) moveToViewcontroller {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginSuccess"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
