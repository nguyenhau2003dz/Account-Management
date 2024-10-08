//
//  WKWebViewController.h
//  Objective_C_TableView_Api_Json
//
//  Created by Nguyễn Đức Hậu on 08/10/2024.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WKWebViewController : UIViewController <WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

