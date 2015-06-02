//
//  ViewController.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ViewController.h"
#import "BackgroundViewHelper.h"
#import "LoginViewController.h"

@interface ViewController ()
@property(strong,nonatomic) RunKeeperDataSource *runKeeperDataSource;
@property(strong,nonatomic) BigOvenDataSource *bigOvenDataSource;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"main tab";
    
    self.runKeeperDataSource = [RunKeeperDataSource new];
    self.bigOvenDataSource = [BigOvenDataSource new];
    
//    int recipeNumber = 466985; //recipeNumber will come from user input
//    [self.bigOvenDataSource getRecipe:recipeNumber];
    
//    [self.bigOvenDataSource getRecipeSearch:@"shrimp"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[BackgroundViewHelper getSharedInstance] start];
}

-(IBAction)buttonPressed:(id)sender{
//    LoginViewController *controller = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
}


@end
