//
//  FavoriteDelegate.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/19/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FavoriteDelegate <NSObject>
-(void)reloadFavoritesWhenChanged;
@end

NS_ASSUME_NONNULL_END
