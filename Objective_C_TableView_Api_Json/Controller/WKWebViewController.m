//
//  WKWebViewController.m
//  Objective_C_TableView_Api_Json
//
//  Created by Nguyễn Đức Hậu on 08/10/2024.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewController ()

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        // Thiết lập WKWebView delegate
        self.webView.navigationDelegate = self;
        
        // Tạo URL và tải trang
        NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/shorts/pnSFS5vEfWA"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
}
// Hiển thị activityIndicator khi bắt đầu tải trang
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.indicator startAnimating];
}

// Dừng activityIndicator khi trang đã tải xong
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.indicator stopAnimating];
}


@end
