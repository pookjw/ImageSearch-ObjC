//
//  SearchModel.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchModel.h"

@implementation SearchModel

-(instancetype)init {
    self.apiKey = @"dff576e28ce434796a2329a6a2366d76";
    self.API = [[NSURL alloc] initWithString:@"https://dapi.kakao.com/v2/search/image"];
    return self;
}

-(void)request:(NSString *)text pageAt:(NSNumber *)page completionHandler:(void (^)(NSDictionary * _Nonnull))completionHandler errorHandler:(void (^)(NSError * _Nonnull))errorHandler {
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:self.API resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *item1 = [[NSURLQueryItem alloc] initWithName:@"query" value:text];
    NSURLQueryItem *item2 = [[NSURLQueryItem alloc] initWithName:@"page" value:[NSString stringWithFormat:@"%@", page]];
    id queries[] = {item1, item2};
    NSUInteger queriesCount = sizeof(queries) / sizeof(id);
    NSArray *queriesArray = [NSArray arrayWithObjects:queries count:queriesCount];
    components.queryItems = queriesArray;
    
    NSURL *finalURL = components.URL;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:finalURL];
    [request setValue:[NSString stringWithFormat:@"KakaoAK %@", self.apiKey] forHTTPHeaderField:@"Authorization" ];
    NSLog(@"%@", request.allHTTPHeaderFields);
    request.HTTPMethod = @"GET";
    
    // NSURLSessionConfiguration.defaultSessionConfiguration
    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    
    
    // https://m.blog.naver.com/PostView.nhn?blogId=wnwogh88&logNo=221038537707&categoryNo=0&proxyReferer=https:%2F%2Fwww.google.com%2F
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            errorHandler(error);
            return;
        }

        NSError * _Nullable jsonError = nil;
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            errorHandler(jsonError);
            return;
        }
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *results = object;
            completionHandler(results);
        }
    }];
    
    [task resume];
}
@end
