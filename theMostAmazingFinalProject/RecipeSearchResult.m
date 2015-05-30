//
//  RecipeSearchResult.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 5/30/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RecipeSearchResult.h"

@implementation RecipeSearchResult

-(id)initWithJSONDict:(NSDictionary *)jsonDict
{
    self = [super init];
    
    if (self)
    {
        self.strSearchYieldNumber = [[jsonDict objectForKey:@"YieldNumber"] stringValue];
        self.strSearchTitle = [jsonDict objectForKey:@"Title"];
        self.strSearchQualityScore = [[jsonDict objectForKey:@"QualityScore"] stringValue];
        self.strSearchImageURL120 = [jsonDict objectForKey:@"ImageURL120"];
        self.strSearchStarRating = [[jsonDict objectForKey:@"StarRating"] stringValue];
        self.strSearchRecipeID = [[jsonDict objectForKey:@"RecipeID"] stringValue];
        self.strSearchCategory = [jsonDict objectForKey:@"Category"];
        self.strSearchCuisine = [jsonDict objectForKey:@"Cuisine"];
    }
    
    return self;
}

@end
