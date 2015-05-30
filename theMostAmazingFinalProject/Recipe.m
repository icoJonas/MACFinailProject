//
//  Recipe.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

-(id)initNewRecipeWithJSON:(NSDictionary *)jsonDict{
    self = [super init];
    
    if (self)
    {
        self.strRecipeCuisine = [jsonDict objectForKey:@"Cuisine"];
        self.strRecipeStarRating = [[jsonDict objectForKey:@"StarRating"] stringValue];
        self.strRecipeReviewCount = [[jsonDict objectForKey:@"ReviewCount"] stringValue];
        self.strRecipePrimaryIngredient = [jsonDict objectForKey:@"PrimaryIngredient"];
        self.strRecipeTotalMinutes = [[jsonDict objectForKey:@"TotalMinutes"] stringValue];
        self.strRecipeCategory = [jsonDict objectForKey:@"Category"];
        self.dictRecipeNutrionInfo = [jsonDict objectForKey:@"NutritionInfo"];
        self.strRecipeYieldNumber = [[jsonDict objectForKey:@"YieldNumber"] stringValue];
        self.strRecipeWebURL = [jsonDict objectForKey:@"WebURL"];
        self.strRecipeInstructions = [jsonDict objectForKey:@"Instructions"];
        self.strRecipeYieldUnit = [jsonDict objectForKey:@"YieldUnit"];
        self.strRecipeID = [[jsonDict objectForKey:@"RecipeID"] stringValue];
        self.strRecipeTitle = [jsonDict objectForKey:@"Title"];
        self.strRecipeImageURL = [jsonDict objectForKey:@"ImageURL"];
        self.arrRecipeIngredients = [jsonDict objectForKey:@"Ingredients"];
        self.strRecipePoster = [[jsonDict objectForKey:@"Poster"] objectForKey:@"UserName"];
        self.strRecipeHeroPhotoURL = [jsonDict objectForKey:@"HeroPhotoUrl"];
        self.strRecipeFavoriteCount = [[jsonDict objectForKey:@"FavoriteCount"] stringValue];
    }
    
    return self;
}


@end
