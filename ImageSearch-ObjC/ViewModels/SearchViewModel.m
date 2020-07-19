//
//  SearchViewModel.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "SearchViewModel.h"
#import "FavoritesModel.h"

@implementation SearchViewModel
-(instancetype)init {
    self.searchResult = @{
        @"documents": @[
                @{
                    @"display_sitename": @"Demo1",
                    @"doc_url": @"http://informluke.tistory.com/47",
                    @"image_url": @"http://cfile9.uf.tistory.com/image/99D9193B5EA7F2B5123797",
                    @"thumbnail_url": @"https://search1.kakaocdn.net/argon/130x130_85_c/9pAuRoSkaNA"
                },
                @{
                    @"display_sitename": @"Demo2",
                    @"doc_url": @"https://www.naver.com",
                    @"image_url": @"https://pds.joins.com/news/component/htmlphoto_mmdata/201902/21/1ab789f1-0f98-447d-8c74-791eb56793e8.jpg",
                    @"thumbnail_url": @"https://search1.kakaocdn.net/argon/130x130_85_c/Fpo7UH3l5G0"
                }
        ]
    };
    self.model = [[SearchModel alloc] init];
    return self;
}

- (void)dealloc {
    NSLog(@"deallocated: SearchViewModel");
}

-(void)request:(NSString *)text pageAt:(NSNumber *)page completionHandler:(void (^)(NSDictionary * _Nonnull))completionHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler {
    [self.model request:text pageAt:page completionHandler:completionHandler errorHandler:errorHandler];
}

-(NSMutableArray<NSDictionary *> * _Nonnull)getFavorites {
    return [FavoritesModel.sharedInstance favorites];
}

-(void)registerObjectToModel:(id<FavoritesDelegate>)object {
    [FavoritesModel.sharedInstance registerObject:object];
}

-(BOOL)isFavorited:(NSDictionary *) dic {
    return [[FavoritesModel.sharedInstance isFavorited:dic][@"favorited"] boolValue];
}

@end
