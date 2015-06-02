//
//  RecipeViewController.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RecipeViewController.h"
#import "BackgroundViewHelper.h"
#import "ImageHelper.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navNavbar.title = self.recipeToDisplay.strRecipeTitle;
    
    self.lblCategory.text = [NSString stringWithFormat:@"Category: %@",self.recipeToDisplay.strRecipeCategory];
    self.lblCuisine.text = [NSString stringWithFormat:@"Cuisine: %@", self.recipeToDisplay.strRecipeCuisine];
    self.lblMainIngredient.text = [NSString stringWithFormat:@"Main ingredient: %@",self.recipeToDisplay.strRecipePrimaryIngredient];;
    self.lblPrepTime.text = [NSString stringWithFormat:@"Prep time: %@ minutes",self.recipeToDisplay.strRecipeTotalMinutes];
    self.lblRating.text = [NSString stringWithFormat:@"%g/5 stars", [self.recipeToDisplay.strRecipeStarRating floatValue]];
    self.lblYield.text = [NSString stringWithFormat:@"Yields: %@ %@", self.recipeToDisplay.strRecipeYieldNumber, self.recipeToDisplay.strRecipeYieldUnit];
    
//    [ImageHelper setImage:self.imgRecipeImage FromPath:self.recipeToDisplay.strRecipeImageURL];
    dispatch_queue_t tempQueue = dispatch_queue_create("tempQueue", nil);
    dispatch_async(tempQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imgRecipeImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.recipeToDisplay.strRecipeImageURL]]];
            self.imgRecipeImage.frame = CGRectMake(22, 44, 276, 276);
        });
    });
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

- (IBAction)btnBackPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
