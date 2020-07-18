//
//  WebViewController.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(donebuttonPressed)];
    self.navigationItem.rightBarButtonItem = self.doneButton;
    
    self.wkWebView = [[WKWebView alloc] init];
    [self.view addSubview:self.wkWebView];
    self.wkWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.wkWebView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.wkWebView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.wkWebView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.wkWebView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.allowsBackForwardNavigationGestures = YES;
    
    self.toolBar = [[UIToolbar alloc] init];
    self.backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.left.circle"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedBackButton)];
    self.forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.right.circle"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedForwardButton)];
    self.flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.refreshButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.clockwise"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedRefreshButton)];
    self.shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"square.and.arrow.up"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedShareButton)];
    self.safariButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"safari"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedSafariButton)];
    [self.view addSubview:self.toolBar];
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.toolBar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [self.toolBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.toolBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [self.toolBar setItems:@[self.backButton, self.forwardButton, self.flexibleItem, self.refreshButton, self.shareButton, self.safariButton]];
    
    [self reloadToolBarImages];
    
    self.request = [[NSMutableURLRequest alloc] initWithURL:self.url];
    self.request.HTTPMethod = @"POST";
    [self.wkWebView loadRequest:self.request];
}

- (void)donebuttonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pressedBackButton {
    [self.wkWebView goBack];
}

- (void)pressedForwardButton {
    [self.wkWebView goForward];
}

- (void)pressedRefreshButton {
    if (self.wkWebView.loading) {
        [self.wkWebView stopLoading];
    } else {
        [self.wkWebView reload];
    }
}

- (void)pressedShareButton {
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[[self.wkWebView URL]] applicationActivities:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)pressedSafariButton{
    [UIApplication.sharedApplication openURL:self.url options:@{} completionHandler:nil];
}

- (void)reloadToolBarImages {
    self.backButton.enabled = self.wkWebView.canGoBack;
    self.forwardButton.enabled = self.wkWebView.canGoForward;
    
    if (self.wkWebView.loading) {
        self.refreshButton.image = [UIImage systemImageNamed:@"xmark"];
    } else {
        self.refreshButton.image = [UIImage systemImageNamed:@"arrow.clockwise"];
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self reloadToolBarImages];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = self.wkWebView.title;
    [self reloadToolBarImages];
}

@end
