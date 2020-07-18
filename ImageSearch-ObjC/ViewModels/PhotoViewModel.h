//
//  PhotoViewModel.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoViewModel : NSObject
@property NSString *display_sitename;
@property NSURL *image_url;
@property NSURL *doc_url;

-(void)loadImage:(NSURL *)url completionHandler:(void(^)(UIImage * _Nonnull))completionHandler;
@end

NS_ASSUME_NONNULL_END
