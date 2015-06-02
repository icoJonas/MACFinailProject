//
//  BigOvenDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Mac on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceHandler.h"
#import "Recipe.h"
#import "RecipeSearchResult.h"

@interface BigOvenDataSource : NSObject <WebServiceHandlerDelegate>{
    int currentOperation;
    WebServiceHandler *webHandler;
}

-(void)getRecipe:(int)recipeNumber;
-(void)getRecipeSearch:(NSString *)keyword;
-(void)getRecipeFavorites;


@end
