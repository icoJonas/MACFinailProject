//
//  CookingViewController.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "CookingViewController.h"
#import "RecipeSearchViewController.h"
#import "BackgroundViewHelper.h"

@interface CookingViewController () <UIAlertViewDelegate>

@end

@implementation CookingViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Cook";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - Button methods
- (IBAction)btnSearchForRecipesPressed:(UIButton *)sender
{
    //Launch a UIAlertview prompting the user for where to search
    UIAlertView *alertRecipeSearchDomain = [[UIAlertView alloc] initWithTitle:@"Recipe Search"
message:@"Please select where I should search" delegate:self cancelButtonTitle:@"Local" otherButtonTitles:@"BigOven.com", nil];
    [alertRecipeSearchDomain show];
}


-(IBAction)btnViewSavedRecipesPressed:(UIButton *)sender
{
    
}

#pragma mark - UIAlertView delegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"The user selected %@", [alertView buttonTitleAtIndex:buttonIndex]);
    
    //Present the next view controller.
    RecipeSearchViewController *recipeSVC = [[RecipeSearchViewController alloc] initWithNibName:@"RecipeSearchViewController" bundle:nil];
    
//    [self presentViewController:recipeSVC animated:YES completion:nil];
    
    CATransition* transition = [CATransition animation];
    transition.duration = .5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:recipeSVC animated:YES];
}

@end
