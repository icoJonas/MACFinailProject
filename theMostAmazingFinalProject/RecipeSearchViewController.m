//
//  RecipeSearchViewController.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RecipeSearchViewController.h"
#import "BackgroundViewHelper.h"
#import "AnimationHelper.h"

@interface RecipeSearchViewController () <UISearchBarDelegate>

@end

@implementation RecipeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"User is searching for %@", searchBar.text);
    [AnimationHelper changeViewSize:searchBar withFrame:CGRectMake(searchBar.frame.origin.x, self.view.frame.size.height-searchBar.frame.size.height, searchBar.frame.size.width, searchBar.frame.size.height) withDuration:1.0 andWait:0.0];
}

@end
