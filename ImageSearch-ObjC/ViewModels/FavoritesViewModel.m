//
//  FavoritesViewModel.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/19/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "FavoritesViewModel.h"
#import "FavoritesModel.h"
#import "FavoritesDelegate.h"

@implementation FavoritesViewModel
-(NSMutableArray<NSDictionary *> * _Nonnull)getFavorites {
    return [FavoritesModel.sharedInstance favorites];
}
-(void)registerObjectToModel:(id<FavoritesDelegate>)object {
    [FavoritesModel.sharedInstance registerObject:object];
}
@end
