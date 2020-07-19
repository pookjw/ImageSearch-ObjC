//
//  FavoritesViewController.m
//  ImageSearch-ObjC
//
//  Created by pook on 7/17/20.
//  Copyright © 2020 jinwoopeter. All rights reserved.
//

#import "FavoritesViewController.h"
#import "PhotoViewController.h"
#import "UIImage+Resize.h"

@implementation FavoritesViewController

+ (instancetype)initWithViewModel {
    FavoritesViewController *vc = [[FavoritesViewController alloc] init];
    vc.viewModel = [[FavoritesViewModel alloc] init];
    [vc.viewModel registerObjectToModel:vc];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup {
    self.title = @"Favorites";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    NSDictionary *dic = [self.viewModel getFavorites][indexPath.row];
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
    
    [self.viewModel loadThumbnailImage:[NSURL URLWithString: [self.viewModel getFavorites][indexPath.row][@"thumbnail_url"]] completionHandler:^(UIImage * image){
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.viewModel getFavorites] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoViewController *viewController = [PhotoViewController initWithViewModel];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    viewController.viewModel.dic = [self.viewModel getFavorites][indexPath.row];
    [self presentViewController:navigationController animated:YES completion:^{
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    [cell setSelected:NO animated:YES];
}

- (void)reloadFavoritesWhenChanged {
    [self.tableView reloadData];
}

@end
