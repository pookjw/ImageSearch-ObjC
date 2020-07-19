//
//  FavoriteModel.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/19/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteDelegate.h"
#import "FavoriteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteModel : NSObject
@property (nonatomic) NSMutableArray<id<FavoriteDelegate>> *objects;
@property (nonatomic) NSMutableArray<NSDictionary*> * favorites;
+(instancetype)sharedInstance;
-(void)invokeObjectsMethods;
-(void)registerObject:(id<FavoriteDelegate>)object;
-(void)unregisterObject:(id<FavoriteDelegate>)object;
-(void)updateFavorite:(NSDictionary*)dic;
-(NSDictionary*)isFavorited:(NSDictionary*)dic;
@end

NS_ASSUME_NONNULL_END
