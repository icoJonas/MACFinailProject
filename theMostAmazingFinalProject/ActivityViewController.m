//
//  ActivityViewController.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/4/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ActivityViewController.h"
#import "BackgroundViewHelper.h"
#import "AnimationHelper.h"
#import "OBShapedButton.h"

@interface ActivityViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lblPostActivity;
@property (strong, nonatomic) IBOutlet UILabel *lblViewProgress;
@property (strong, nonatomic) IBOutlet OBShapedButton *btnPostActivity;
@property (strong, nonatomic) IBOutlet OBShapedButton *btnViewProgress;

@end

@implementation ActivityViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Activity";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lblPostActivity.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    self.lblViewProgress.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

- (IBAction)btnPostActivityPressed:(id)sender
{
}

- (IBAction)btnViewProgressPressed:(id)sender
{
}

@end
