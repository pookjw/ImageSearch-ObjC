//
//  FavoritesModel.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/19/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoritesDelegate.h"
#import "FavoritesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesModel : NSObject
@property (nonatomic) NSMutableArray<id<FavoritesDelegate>> *objects;
@property (nonatomic) NSMutableArray<NSDictionary*> * favorites;
+(instancetype)sharedInstance;
-(void)invokeObjectsMethods;
-(void)registerObject:(id<FavoritesDelegate>)object;
-(void)unregisterObject:(id<FavoritesDelegate>)object;
-(void)updateFavorite:(NSDictionary*)dic;
-(NSDictionary*)isFavorited:(NSDictionary*)dic;
@end

NS_ASSUME_NONNULL_END
