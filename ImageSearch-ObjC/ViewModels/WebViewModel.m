//
//  WebViewModel.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "WebViewModel.h"

@implementation WebViewModel
- (void)dealloc {
    NSLog(@"deallocated: WebViewModel");
}

-(void)openSafari:(NSURL *)url {
    [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
}
@end
