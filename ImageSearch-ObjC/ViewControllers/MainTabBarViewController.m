//
//  MainTabBarViewController.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "SearchViewController.h"
#import "FavoritesViewController.h"

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.searchViewController = [[SearchViewController alloc] init];
    self.favoritesViewController = [[FavoritesViewController alloc] init];
    
    self.firstNavigationController = [[UINavigationController alloc] initWithRootViewController:self.searchViewController];
    self.secondNavigationController = [[UINavigationController alloc] initWithRootViewController:self.favoritesViewController];
    
    self.firstNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
    self.secondNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    
    id objects[] = {self.firstNavigationController, self.secondNavigationController};
    NSUInteger count = sizeof(objects) / sizeof(id);
    NSArray *array = [NSArray arrayWithObjects:objects count:count];
    
    self.viewControllers = array;
    self.selectedIndex = 0;
}

@end
