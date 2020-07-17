//
//  FavoritesViewController.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property UITableView *tableView;
- (void)setupUI;
@end

NS_ASSUME_NONNULL_END
