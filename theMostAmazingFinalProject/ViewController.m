//
//  ViewController.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ViewController.h"
#import "BackgroundViewHelper.h"

@interface ViewController ()
@property(strong,nonatomic) RunKeeperDataSource *runKeeperDataSource;
@property(strong,nonatomic) BigOvenDataSource *bigOvenDataSource;
@end


@implementation ViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"main tab";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

@end
