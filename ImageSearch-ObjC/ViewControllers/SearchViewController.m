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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}

- (void)setup {
    self.title = @"Search";
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.view.backgroundColor = UIColor.blueColor;
    
    
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
        
    
    self.navigationController.navigationBar.barTintColor = UIColor.redColor;
//    self.navigationController.navigationBar.tintColor = UIColor.redColor;
    self.navigationController.navigationBar.backgroundColor = UIColor.redColor;
//    self.searchController.searchBar.barTintColor = UIColor.redColor;
//    self.searchController.searchBar.tintColor = UIColor.redColor;
    self.searchController.searchBar.backgroundColor = UIColor.redColor;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = UIColor.redColor;
    
    UIView *tempView = [UIView new];
    [self.view.superview addSubview:tempView];
    NSLog(@"%@", self.view.superview);
    tempView.translatesAutoresizingMaskIntoConstraints = NO;
    [tempView.topAnchor constraintEqualToAnchor:self.view.superview.topAnchor].active = YES;
    [tempView.leadingAnchor constraintEqualToAnchor:self.view.superview.leadingAnchor].active = YES;
    [tempView.trailingAnchor constraintEqualToAnchor:self.view.superview.trailingAnchor].active = YES;
    [tempView.heightAnchor constraintEqualToConstant:60].active = YES;
    tempView.backgroundColor = UIColor.redColor;
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
    
    [self.viewModel loadThumbnailImage:[NSURL URLWithString: self.viewModel.searchResult[@"documents"][indexPath.row][@"thumbnail_url"]] completionHandler:^(UIImage * image){
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
    }];
    
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
