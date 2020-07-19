//
//  FavoriteModel.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/19/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "FavoriteModel.h"

@implementation FavoriteModel

-(instancetype)init {
    self.objects = [[NSMutableArray alloc] init];
    self.favorites = [[NSMutableArray alloc] init];
    return self;
}

+(instancetype)sharedInstance {
    static FavoriteModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FavoriteModel alloc] init];
    });
    return sharedInstance;
}

-(void)invokeObjectsMethods {
    [self.objects enumerateObjectsUsingBlock:^(id<FavoriteDelegate> _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
        [obj reloadFavoritesWhenChanged];
    }];
}

-(void)registerObject:(id<FavoriteDelegate>)object {
    if ([self.objects containsObject:object]) {
        NSLog(@"%@ is alreay registered!", object);
        return;
    }
    [self.objects insertObject:object atIndex:self.objects.count];
}

-(void)unregisterObject:(id<FavoriteDelegate>)object {
    if (![self.objects containsObject:object]) {
        NSLog(@"%@ is not registered!", object);
        return;
    }
    [self.objects removeObject:object];
}

-(void)setFavorites:(NSMutableArray<NSDictionary*> *)favorites {
    [self invokeObjectsMethods];
    _favorites = favorites;
}

-(void)updateFavorite:(NSDictionary*)dic {
    if ([[self isFavorited:dic][@"favorited"] boolValue]) {
        NSNumber *idx = [self isFavorited:dic][@"idx"];
        [self.favorites removeObjectAtIndex:[idx intValue]];
    } else {
        [self.favorites addObject:dic];
    }
    [self invokeObjectsMethods];
}

-(NSDictionary*)isFavorited:(NSDictionary*)dic {
    NSDictionary __block *returnValue = nil;
    [self.favorites enumerateObjectsUsingBlock:^(NSDictionary* _Nonnull with, NSUInteger idx, BOOL * _Nonnull stop){
        @autoreleasepool {
            BOOL display_sitename = ([dic[@"display_sitename"] isEqualToString:with[@"display_sitename"]]);
            BOOL doc_url = ([dic[@"doc_url"] isEqualToString:with[@"doc_url"]]);
            BOOL image_url = ([dic[@"image_url"] isEqualToString:with[@"image_url"]]);
            BOOL thumbnail_url = ([dic[@"thumbnail_url"] isEqualToString:with[@"thumbnail_url"]]);
            BOOL result = (display_sitename && doc_url && image_url && thumbnail_url);
            
            if (result) {
                returnValue = @{
                    @"favorited": @YES,
                    @"idx": [NSNumber numberWithInteger:idx]
                };
                *stop = YES;
            }
        }
    }];
    if (returnValue == nil) {
        returnValue = @{
            @"favorited": @NO
        };
    }
    return returnValue;
}

@end
