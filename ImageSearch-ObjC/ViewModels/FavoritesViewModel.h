//
//  FavoritesViewModel.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/19/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoritesDelegate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesViewModel : NSObject
-(NSMutableArray<NSDictionary *> * _Nonnull)getFavorites;
-(void)registerObjectToModel:(id<FavoritesDelegate>)object;
-(void)loadThumbnailImage:(NSURL *)url completionHandler:(void (^)(UIImage * _Nonnull))completionHandler;
@end

NS_ASSUME_NONNULL_END
