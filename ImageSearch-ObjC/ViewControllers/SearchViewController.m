//
//  SearchViewController.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "SearchViewController.h"
#import "UIImage+Resize.h"

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[SearchViewModel alloc] init];
    [self setup];
}

- (void)setup {
    self.title = @"Search";
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.tableView = [[UITableView alloc] init];
    //    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.navigationItem.searchController = self.searchController;
    self.searchController.searchBar.delegate = self;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell __block *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    UIImage *placeholder = [UIImage imageWithImage:[[UIImage alloc] init] scaledToFillSize:CGSizeMake(57, 57)];
    NSString *title = self.viewModel.searchResult[@"documents"][indexPath.row][@"display_sitename"];
    NSString *url = self.viewModel.searchResult[@"documents"][indexPath.row][@"doc_url"];
    
    cell.imageView.image = placeholder;
    if ([title isEqualToString:@""]) {
        cell.textLabel.text = @"(noname)";
    } else {
        cell.textLabel.text = title;
    }
    cell.detailTextLabel.text = url;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.viewModel.searchResult[@"documents"][indexPath.row][@"thumbnail_url"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData: imageData];
        });
    });
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.searchResult[@"documents"] count];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSString * _Nonnull text = searchBar.text;
    [self.viewModel request:text pageAt:@1 completionHandler:^(NSDictionary * _Nonnull dic) {
        NSLog(@"%@", dic);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = text;
            self.viewModel.searchResult = dic;
            NSLog(@"%@", dic);
            [self.tableView reloadData];
        });
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    [self.searchController setActive:NO];
}

@end
