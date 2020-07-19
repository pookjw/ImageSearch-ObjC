//
//  FavoritesViewModel.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/19/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "FavoritesViewModel.h"
#import "FavoriteModel.h"
#import "FavoriteDelegate.h"

@implementation FavoritesViewModel
-(NSMutableArray<NSDictionary *> * _Nonnull)getFavorites {
    return [FavoriteModel.sharedInstance favorites];
}
-(void)registerObjectToModel:(id<FavoriteDelegate>)object {
    [FavoriteModel.sharedInstance registerObject:object];
}
@end
