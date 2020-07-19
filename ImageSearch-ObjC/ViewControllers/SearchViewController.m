//
//  SearchViewController.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "SearchViewController.h"
#import "PhotoViewController.h"
#import "UIImage+Resize.h"

@implementation SearchViewController

+ (instancetype)initWithViewModel {
    SearchViewController *vc = [[SearchViewController alloc] init];
    vc.viewModel = [[SearchViewModel alloc] init];
    [vc.viewModel registerObjectToModel:vc];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.title = @"Search";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.tableView = [[UITableView alloc] init];
    //    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.navigationItem.searchController = self.searchController;
    self.searchController.searchBar.delegate = self;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    NSDictionary *dic = self.viewModel.searchResult[@"documents"][indexPath.row];
    UIImage *placeholder = [UIImage imageWithImage:[[UIImage alloc] init] scaledToFillSize:CGSizeMake(57, 57)];
    NSString *display_sitename = dic[@"display_sitename"];
    NSString *doc_url = dic[@"doc_url"];
    
    cell.imageView.image = placeholder;
    if ([display_sitename isEqualToString:@""]) {
        cell.textLabel.text = @"(no display_sitename)";
    } else {
        cell.textLabel.text = display_sitename;
    }
    cell.detailTextLabel.text = doc_url;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if ([self.viewModel isFavorited:dic]) {
        cell.textLabel.textColor = UIColor.systemOrangeColor;
    } else {
        cell.textLabel.textColor = UIColor.labelColor;
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoViewController *viewController = [PhotoViewController initWithViewModel];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    viewController.viewModel.dic = self.viewModel.searchResult[@"documents"][indexPath.row];
    [self presentViewController:navigationController animated:YES completion:^{
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    [cell setSelected:NO animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString * _Nonnull text = searchBar.text;
    [self.viewModel request:text pageAt:@1 completionHandler:^(NSDictionary * _Nonnull dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = text;
            self.viewModel.searchResult = dic;
            [self.tableView reloadData];
        });
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    [searchBar resignFirstResponder];
    [self.searchController setActive:NO];
}

- (void)reloadFavoritesWhenChanged {
    [self.tableView reloadData];
}

@end
