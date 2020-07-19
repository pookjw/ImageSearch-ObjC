//
//  SearchViewModel.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"
#import "FavoritesDelegate.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewModel : NSObject
@property NSDictionary * _Nonnull searchResult;
@property SearchModel *model;
-(void)request:(NSString *)text pageAt:(NSNumber *)page completionHandler:(void (^)(NSDictionary * _Nonnull))completionHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler;
-(NSMutableArray<NSDictionary *> * _Nonnull)getFavorites;
-(void)registerObjectToModel:(id<FavoritesDelegate>)object;
-(BOOL)isFavorited:(NSDictionary *) dic;
-(void)loadThumbnailImage:(NSURL *)url completionHandler:(void (^)(UIImage * _Nonnull))completionHandler;
@end

NS_ASSUME_NONNULL_END
