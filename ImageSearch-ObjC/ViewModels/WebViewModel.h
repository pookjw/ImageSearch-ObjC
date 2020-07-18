//
//  WebViewModel.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WebViewModel : NSObject
@property NSURL *url;
-(void)openSafari:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
