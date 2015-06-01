//
//  BigOvenDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "BigOvenDataSource.h"

static NSString * const BIGOVEN_RECIPE_REQUEST_URL = @"http://api.bigoven.com/recipe/%d?api_key=dvx0869aFk8U96H9396Ocbux33T0YYM6";

static NSString * const BIGOVER_RECIPE_SEARCH_REQUEST_URL = @"http://api.bigoven.com/recipes/?api_key=dvx0869aFk8U96H9396Ocbux33T0YYM6&pg=3&rpp=25&title_kw=%@";

@implementation BigOvenDataSource

enum OPERATIONS {
    GET_RECIPE = 1,
    GET_RECIPE_SEARCH = 2,
};

-(instancetype)init{
    self = [super init];
    if (self) {
        currentOperation = 0;
        webHandler = [[WebServiceHandler alloc] initWithDelegate:self];
    }
    return self;
}

-(void)getRecipe:(int)recipeNumber
{
    currentOperation = GET_RECIPE;
    NSDictionary *jsonHeader = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"Accept", nil];
    [webHandler doRequest:[NSString stringWithFormat:BIGOVEN_RECIPE_REQUEST_URL,recipeNumber] withParameters:nil andHeaders:jsonHeader andHTTPMethod:@"GET"];
}

-(void)getRecipeSearch:(NSString *)keyword
{
    currentOperation = GET_RECIPE_SEARCH;
    NSDictionary *jsonHeader = [NSDictionary dictionaryWithObjectsAndKeys:@"application/json", @"Accept", nil];
    [webHandler doRequest:[NSString stringWithFormat:BIGOVER_RECIPE_SEARCH_REQUEST_URL, keyword] withParameters:nil andHeaders:jsonHeader andHTTPMethod:@"GET"];
}

-(void)webServiceCallFinished:(id)data
{
    NSError *error;
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"There was an error in parsing the recipe's JSON file");
    }
    else if (currentOperation == GET_RECIPE)
    {
        //Create a recipe object
        Recipe *myRecipe = [[Recipe alloc] initNewRecipeWithJSON:jsonObject];
        NSLog(@"Recipe for %@ recieved", myRecipe.strRecipeTitle);
    }
    else if (currentOperation == GET_RECIPE_SEARCH)
    {
        NSMutableArray *arrSearchResults = [NSMutableArray new];
        NSArray *searchResultsArray = [jsonObject objectForKey:@"Results"];
        
        for (NSDictionary *aSearchResultDict in searchResultsArray) {
            RecipeSearchResult *aSearch = [[RecipeSearchResult alloc] initWithJSONDict:aSearchResultDict];
            [arrSearchResults addObject:aSearch];
        }
        
        NSLog(@"Description of search results: %@", arrSearchResults);
    }

}

-(void)webServiceCallError:(NSError *)error
{
    NSLog(@"%@",error.description);
}

@end
