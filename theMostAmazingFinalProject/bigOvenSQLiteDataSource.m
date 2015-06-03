//
//  bigOvenSQLiteDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "bigOvenSQLiteDataSource.h"

@implementation bigOvenSQLiteDataSource

-(void)insertOrUpdate:(Recipe *)recipe{
    
    for (NSDictionary *anIngredient in recipe.arrRecipeIngredients) {
        NSString *quantity = [anIngredient objectForKey:@"DisplayQuantity"];
        NSString *name = [anIngredient objectForKey:@"Name"];
        NSString *quantityUnit = [anIngredient objectForKey:@"Unit"];
        NSString *metricUnit = [anIngredient objectForKey:@"MetricUnit"];
        NSString *metricQuantity = [anIngredient objectForKey:@"MetricDisplayQuantity"];
        
        NSMutableDictionary *ingredientDic = [NSMutableDictionary new];
        [ingredientDic setObject:[anIngredient objectForKey:@"IngredientID"] forKey:@"IngredientID"];
        [ingredientDic setObject:quantity forKey:@"DisplayQuantity"];
        [ingredientDic setObject:name forKey:@"Name"];
        [ingredientDic setObject:quantityUnit forKey:@"Unit"];
        [ingredientDic setObject:metricUnit forKey:@"MetricUnit"];
        [ingredientDic setObject:metricQuantity forKey:@"MetricDisplayQuantity"];
        
        NSArray *currentIngredient = [self executeQuery:[NSString stringWithFormat:@"SELECT IngredientID FROM bigoven_ingredients WHERE IngredientID = %@",[anIngredient objectForKey:@"IngredientID"]]];
        if (currentIngredient.count > 0) {
            [self executeUpdateOperation:@"bigoven_ingredients" andData:ingredientDic andFilter:[NSDictionary dictionaryWithObject:[anIngredient objectForKey:@"IngredientID"] forKey:@"IngredientID"]];
        } else {
            [self executeInsertOperation:@"bigoven_ingredients" andData:ingredientDic];
            [self executeInsertOperation:@"bigoven_ingredientsForRecipe" andData:[NSDictionary dictionaryWithObjects:@[recipe.strRecipeID, [anIngredient objectForKey:@"IngredientID"]] forKeys:@[@"recipe_id", @"ingredient_id"]]];
        }
    }

    
    NSMutableDictionary *recipeDic = [NSMutableDictionary new];
    [recipeDic setObject:recipe.strRecipeID forKey:@"id"];
    [recipeDic setObject:recipe.strRecipeCuisine forKey:@"cuisine"];
    [recipeDic setObject:recipe.strRecipeStarRating forKey:@"starRating"];
    [recipeDic setObject:recipe.strRecipePrimaryIngredient forKey:@"primaryIngredient"];
    [recipeDic setObject:recipe.strRecipeTotalMinutes forKey:@"totalMinutes"];
    [recipeDic setObject:recipe.strRecipeCategory forKey:@"category"];
    [recipeDic setObject:recipe.strRecipeYieldNumber forKey:@"yieldNumber"];
    [recipeDic setObject:recipe.strRecipeWebURL forKey:@"webURL"];
    [recipeDic setObject:recipe.strRecipeInstructions forKey:@"instructions"];
    [recipeDic setObject:recipe.strRecipeYieldUnit forKey:@"yieldUnit"];
    [recipeDic setObject:recipe.strRecipeTitle forKey:@"title"];
    [recipeDic setObject:recipe.strRecipeImageURL forKey:@"imageURL"];
    [recipeDic setObject:recipe.strRecipePoster forKey:@"poster"];
    [recipeDic setObject:recipe.strRecipeHeroPhotoURL forKey:@"heroPhotoURL"];
    [recipeDic setObject:recipe.strRecipeFavoriteCount forKey:@"favoriteCount"];
    

    
    NSArray *curretObjects = [self executeSingleSelect:@"bigoven_recipes" andColumnNames:@[@"id"] andFilter:[NSDictionary dictionaryWithObject:recipe.strRecipeID forKey:@"id"] andLimit:2];
    if (curretObjects.count > 0) {
        [self executeUpdateOperation:@"bigoven_recipes" andData:recipeDic andFilter:[NSDictionary dictionaryWithObject:[recipeDic objectForKey:@"id"] forKey:@"Id"]];
    } else {
        [self executeInsertOperation:@"bigoven_recipes" andData:recipeDic];
    }
}

@end
