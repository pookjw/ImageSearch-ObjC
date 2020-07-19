//
//  FavoritesViewController.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoritesViewModel.h"
#import "FavoriteDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FavoriteDelegate>
@property FavoritesViewModel *viewModel;
@property UITableView *tableView;
+ (instancetype)initWithViewModel;
- (void)setup;
@end

NS_ASSUME_NONNULL_END
