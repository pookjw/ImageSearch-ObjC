//
//  PhotoViewController.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoViewController : UIViewController

@property PhotoViewModel *viewModel;

@property UIImageView *imageView;
@property UIBarButtonItem *doneBtton;

@property UIToolbar *toolBar;
@property UIBarButtonItem *saveButton;
@property UIBarButtonItem *firstFlexibleItem;
@property UIBarButtonItem *starButton;
@property UIBarButtonItem *secondFlexibleItem;
@property UIBarButtonItem *safariButton;

-(void)setup;
-(void)pressedDoneButton;
-(void)pressedSafariButton;
@end

NS_ASSUME_NONNULL_END
