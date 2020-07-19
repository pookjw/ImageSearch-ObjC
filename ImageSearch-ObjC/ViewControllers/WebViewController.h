//
//  WebViewController.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WebViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : UIViewController<WKNavigationDelegate>
@property WebViewModel *viewModel;

@property WKWebView *wkWebView;
@property UIBarButtonItem *doneButton;
@property NSMutableURLRequest *request;

@property UIToolbar *toolBar;
@property UIBarButtonItem *backButton;
@property UIBarButtonItem *forwardButton;
@property UIBarButtonItem *flexibleItem;
@property UIBarButtonItem *refreshButton;
@property UIBarButtonItem *shareButton;
@property UIBarButtonItem *safariButton;

+ (instancetype)initWithViewModel;
-(void)setup;
-(void)donebuttonPressed;
-(void)pressedBackButton;
- (void)pressedForwardButton;
-(void)pressedRefreshButton;
-(void)pressedShareButton;
-(void)pressedSafariButton;
-(void)reloadToolBarImages;
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
@end

NS_ASSUME_NONNULL_END
