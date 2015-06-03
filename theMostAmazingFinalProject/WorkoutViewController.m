//
//  WorkoutViewController.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WorkoutViewController.h"
#import "BackgroundViewHelper.h"
#import "AnimationHelper.h"
#import "MuscleSelectionViewController.h"

@interface WorkoutViewController () <WorkoutManagerDataSourceDelegate>

@end

@implementation WorkoutViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Workout";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.wgerDataSource = [WorkoutManagerDataSource new];
    self.wgerDataSource.delegate = self;
    [activityView startAnimating];
    [scheduleButton setHidden:YES];
    [exerciseButton setHidden:YES];
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

-(void)viewDidAppear:(BOOL)animated{
    [AnimationHelper changeViewSize:scheduleButton withFrame:CGRectMake(scheduleButton.frame.origin.x-500, scheduleButton.frame.origin.y, scheduleButton.frame.size.width, scheduleButton.frame.size.height) withDuration:0.0 andWait:0.0];
    [AnimationHelper changeViewSize:exerciseButton withFrame:CGRectMake(exerciseButton.frame.origin.x+500, exerciseButton.frame.origin.y, exerciseButton.frame.size.width, exerciseButton.frame.size.height) withDuration:0.0 andWait:0.0];
    [self.wgerDataSource getCatalogs];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - WorkoutManagerDataSourceDelegate methods

-(void)catalogsUpdated{
    
    [activityView stopAnimating];
    [self performSelector:@selector(animateAfter) withObject:nil afterDelay:0.5];
}

-(void)animateAfter{
    [scheduleButton setHidden:NO];
    [exerciseButton setHidden:NO];
    [AnimationHelper transitionView:scheduleButton toRect:CGRectMake(scheduleButton.frame.origin.x+500, scheduleButton.frame.origin.y, scheduleButton.frame.size.width, scheduleButton.frame.size.height) WithSpringWithDamping:0.6 andVelocity:1.0 andTransitionTime:0.8 andWaitTime:0.0];
    [AnimationHelper transitionView:exerciseButton toRect:CGRectMake(exerciseButton.frame.origin.x-500, exerciseButton.frame.origin.y, exerciseButton.frame.size.width, exerciseButton.frame.size.height) WithSpringWithDamping:0.6 andVelocity:1.0 andTransitionTime:0.8 andWaitTime:0.0];
}

- (IBAction)goToMuscleSelection:(id)sender {
    MuscleSelectionViewController *muscleSelection = [[MuscleSelectionViewController alloc] init];
    [self.navigationController pushViewController:muscleSelection animated:YES];
}


@end
