//
//  PhotoViewController.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "PhotoViewController.h"

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.title = self.display_sitename;
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    self.toolBar = [[UIToolbar alloc] init];
    [self.view addSubview:self.toolBar];
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.toolBar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [self.toolBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.toolBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    
    self.rightBtton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonPressed)];
    self.navigationItem.rightBarButtonItem = self.rightBtton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadImage];
}

- (void)rightButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadImage {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: self.image_url];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData: imageData];
        });
    });
}

@end
