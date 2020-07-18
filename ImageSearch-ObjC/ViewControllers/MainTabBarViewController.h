//
//  MainTabBarViewController.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "FavoritesViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainTabBarViewController : UITabBarController
@property UINavigationController *firstNavigationController;
@property UINavigationController *secondNavigationController;
@property SearchViewController *searchViewController;
@property FavoritesViewController *favoritesViewController;
- (void)setup;
@end

NS_ASSUME_NONNULL_END
