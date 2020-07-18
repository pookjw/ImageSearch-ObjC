//
//  PhotoViewController.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoViewController : UIViewController
@property NSString *display_sitename;
@property NSURL *image_url;
@property NSURL *doc_url;

@property UIImageView *imageView;
@property UIBarButtonItem *rightBtton;
@property UIToolbar *toolBar;
-(void)setup;
-(void)rightButtonPressed;
-(void)loadImage;
@end

NS_ASSUME_NONNULL_END
