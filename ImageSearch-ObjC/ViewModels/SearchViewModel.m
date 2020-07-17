//
//  SearchViewModel.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "SearchViewModel.h"

@implementation SearchViewModel
-(instancetype)init {
    self.searchResult = @{
        @"documents": @[
                @{
                    @"display_sitename": @"Demo1",
                    @"doc_url": @"https://github.com/pookjw"
                },
                @{
                    @"display_sitename": @"Demo2",
                    @"doc_url": @"https://github.com/pookjw"
                }
        ]
    };
    self.model = [[SearchModel alloc] init];
    return self;
}

-(void)request:(NSString *)text pageAt:(NSNumber *)page completionHandler:(void (^)(NSDictionary * _Nonnull))completionHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler {
    [self.model request:text pageAt:page completionHandler:completionHandler errorHandler:errorHandler];
}

@end
