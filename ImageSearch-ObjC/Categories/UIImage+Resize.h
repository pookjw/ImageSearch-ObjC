//
//  UIImage+Resize.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage(Resize)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
