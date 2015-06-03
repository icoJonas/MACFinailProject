//
//  ExerciseSelectionViewController.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ExerciseSelectionViewController.h"
#import "wgerSQLiteDataSource.h"

@interface ExerciseSelectionViewController ()

@end

@implementation ExerciseSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    wgerSQLiteDataSource *dataSource = [wgerSQLiteDataSource new];
    NSLog(@"%@",[dataSource getExercisesForMuscle:[self.muscleDic objectForKey:@"id"]]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
