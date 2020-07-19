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

-(void)loadThumbnailImage:(NSURL *)url completionHandler:(void (^)(UIImage * _Nonnull))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: url];
        UIImage * image = [UIImage imageWithData:imageData];
        completionHandler(image);
    });
}
@end
