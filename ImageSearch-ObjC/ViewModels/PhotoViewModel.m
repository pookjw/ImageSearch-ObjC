//
//  PhotoViewModel.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/18/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "PhotoViewModel.h"

@implementation PhotoViewModel

- (void)dealloc {
    NSLog(@"deallocated: PhotoViewModel");
}

-(void)loadImage:(NSURL *)url completionHandler:(void(^)(UIImage * _Nonnull))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: url];
        UIImage * image = [UIImage imageWithData:imageData];
        completionHandler(image);
    });
}

-(void)registerObjectToModel:(id<FavoritesDelegate>)object {
    [FavoritesModel.sharedInstance registerObject:object];
}

-(void)unregisterObjectFromModel:(id<FavoritesDelegate>)object {
    [FavoritesModel.sharedInstance unregisterObject:object];
}

-(void)updateFavorite:(NSDictionary *) dic {
    [FavoritesModel.sharedInstance updateFavorite:dic];
}

-(BOOL)isFavorited:(NSDictionary *) dic {
    return [[FavoritesModel.sharedInstance isFavorited:dic][@"favorited"] boolValue];
}
@end
