//
//  ViewProgressViewController.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ViewProgressViewController.h"
#import "BackgroundViewHelper.h"

@interface ViewProgressViewController ()

@end

@implementation ViewProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

@end
