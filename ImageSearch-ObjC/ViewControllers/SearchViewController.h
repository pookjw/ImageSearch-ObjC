//
//  SearchViewController.h
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating>
@property UITableView *tableView;
@property UISearchController *searchController;
@property SearchViewModel *viewModel;
-(void)setup;
@end

NS_ASSUME_NONNULL_END
