//
//  PhotoViewController.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "PhotoViewController.h"
#import "WebViewController.h"

@implementation PhotoViewController
+ (instancetype)initWithViewModel {
    PhotoViewController *vc = [[PhotoViewController alloc] init];
    vc.viewModel = [[PhotoViewModel alloc] init];
    return vc;
}

- (void)dealloc {
    NSLog(@"deallocated: PhotoViewController");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel registerObjectToModel:self];
    NSURL *image_url = [NSURL URLWithString:self.viewModel.dic[@"image_url"]];
    [self.viewModel loadImage:image_url completionHandler:^(UIImage * image){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.viewModel unregisterObjectFromModel:self];
}

- (void)setup {
    self.title = self.viewModel.dic[@"display_sitename"];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.doneBtton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pressedDoneButton)];
    self.navigationItem.rightBarButtonItem = self.doneBtton;
    
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    self.toolBar = [[UIToolbar alloc] init];
    self.saveButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"square.and.arrow.down"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.firstFlexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.starButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"star"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedStarButton)];
    self.secondFlexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.safariButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"safari"] style:UIBarButtonItemStylePlain target:self action:@selector(pressedSafariButton)];
    [self.view addSubview:self.toolBar];
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.toolBar.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [self.toolBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.toolBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [self.toolBar setItems:@[self.saveButton, self.firstFlexibleItem, self.starButton, self.secondFlexibleItem, self.safariButton]];
    
    [self updateFavoritedStatus];
}

- (void)pressedDoneButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pressedStarButton {
    [self.viewModel updateFavorite:self.viewModel.dic];
}

- (void)pressedSafariButton {
    WebViewController *vc = [WebViewController initWithViewModel];
    vc.viewModel.dic = self.viewModel.dic;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)updateFavoritedStatus {
    if ([self.viewModel isFavorited:self.viewModel.dic]) {
        self.starButton.image = [UIImage systemImageNamed:@"star.fill"];
    } else {
        self.starButton.image = [UIImage systemImageNamed:@"star"];
    }
}

- (void)reloadFavoritesWhenChanged {
    [self updateFavoritedStatus];
}

@end
