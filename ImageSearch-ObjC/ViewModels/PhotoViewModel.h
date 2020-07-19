//
//  PhotoViewModel.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FavoritesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoViewModel : NSObject
@property NSDictionary *dic;

-(void)loadImage:(NSURL *)url completionHandler:(void(^)(UIImage * _Nonnull))completionHandler;
-(void)registerObjectToModel:(id<FavoritesDelegate>)object;
-(void)unregisterObjectFromModel:(id<FavoritesDelegate>)object;
-(void)updateFavorite:(NSDictionary *) dic;
-(BOOL)isFavorited:(NSDictionary *) dic;
@end

NS_ASSUME_NONNULL_END
