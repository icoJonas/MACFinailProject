//
//  WorkoutManagerDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WorkoutManagerDataSource.h"
#import "wgerSQLiteDataSource.h"

@implementation WorkoutManagerDataSource

wgerSQLiteDataSource *sqliteDataSource;

enum OPERATIONS {
    GET_CATEGORIES = 1,
    GET_EQUIPMENTS = 2,
    GET_MUSCLES = 3,
    GET_EXERCISES = 4,
    GET_IMAGES = 5,
};

-(instancetype)init{
    self = [super init];
    if (self) {
        currentOperation = 0;
        webHandler = [[WebServiceHandler alloc] initWithDelegate:self];
        sqliteDataSource = [wgerSQLiteDataSource new];
    }
    return self;
}

#pragma mark - Private methods


-(void)storeCategories:(NSDictionary *)dic{
    NSArray *categories = [dic objectForKey:@"results"];
    [sqliteDataSource insertAllNewCategories:categories];
}

-(void)storeEquipments:(NSDictionary *)dic{
    NSArray *equipments = [dic objectForKey:@"results"];
    [sqliteDataSource insertAllNewEquipments:equipments];
}

-(void)storeMuscles:(NSDictionary *)dic{
    NSArray *muscles = [dic objectForKey:@"results"];
    [sqliteDataSource insertAllNewMuscles:muscles];
}

-(void)storeExercises:(NSDictionary *)dic{
    NSArray *exercises = [dic objectForKey:@"results"];
    NSMutableArray *parsedData = [NSMutableArray new];
    for (NSDictionary *aExercise in exercises) {
        int identifier = [[aExercise objectForKey:@"id"] intValue];
        NSString *description = [aExercise objectForKey:@"description"];
        description = [description stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        description = [description stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        description = [description stringByReplacingOccurrencesOfString:@"'" withString:@""];
        NSArray *muscles = [aExercise objectForKey:@"muscles"];
        NSArray *equipment = [aExercise objectForKey:@"equipment"];
        [sqliteDataSource insertEquipments:equipment ForExercise:identifier];
        [sqliteDataSource insertMuscles:muscles ForExercise:identifier];
        NSMutableDictionary *exercisesDic = [[NSMutableDictionary alloc] initWithDictionary:aExercise];
        [exercisesDic removeObjectsForKeys:@[@"license", @"license_author", @"creation_date", @"muscles", @"muscles_secondary", @"equipment"]];
        [exercisesDic setObject:description forKey:@"description"];
        [parsedData addObject:exercisesDic];
    }
    
    [sqliteDataSource insertAllNewExercises:parsedData];
}

-(void)storeImages:(NSDictionary *)dic{
    NSArray *exercises = [dic objectForKey:@"results"];
    NSMutableArray *parsedData = [NSMutableArray new];
    for (NSDictionary *aExercise in exercises) {
        NSMutableDictionary *exercisesDic = [[NSMutableDictionary alloc] initWithDictionary:aExercise];
        [exercisesDic removeObjectsForKeys:@[@"license", @"license_author", @"status", @"is_main"]];
        [exercisesDic setObject:[NSString stringWithFormat:@"https://wger.de/media/%@",[aExercise objectForKey:@"image"]] forKey:@"image"];
        [parsedData addObject:exercisesDic];
    }
    
    [sqliteDataSource insertAllNewImages:parsedData];
}

#pragma mark - Public methods

-(void)getCatalogs{
    currentOperation = GET_CATEGORIES;
    [webHandler doRequest:@"http://wger.de/api/v2/exercisecategory/" andHeaders:nil andHTTPMethod:@"GET"];
}

#pragma mark - WebServiceHandler delegate methods

-(void)webServiceCallFinished:(id)data{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSString *nextPage = nil;
    if (![[jsonObject objectForKey:@"next"] isKindOfClass:[NSNull class]]) {
        nextPage = [jsonObject objectForKey:@"next"];
    }
    
    switch (currentOperation) {
        case GET_CATEGORIES:
            [self storeCategories:jsonObject];
            if (!nextPage) {
                currentOperation = GET_EQUIPMENTS;
                nextPage = @"http://wger.de/api/v2/equipment/";
            }
            break;
            
        case GET_EQUIPMENTS:
            [self storeEquipments:jsonObject];
            if (!nextPage) {
                currentOperation = GET_MUSCLES;
                nextPage = @"http://wger.de/api/v2/muscle/";
            }
            break;
            
        case GET_MUSCLES:
            [self storeMuscles:jsonObject];
            if (!nextPage) {
                currentOperation = GET_EXERCISES;
                nextPage = @"http://wger.de/api/v2/exercise/";
            }
            break;
            
        case GET_EXERCISES:
            [self storeExercises:jsonObject];
            if (!nextPage) {
                currentOperation = GET_IMAGES;
                nextPage = @"http://wger.de/api/v2/exerciseimage/";
            }
            break;
            
        case GET_IMAGES:
            [self storeImages:jsonObject];
            break;
            
        default:
            break;
    }
        
    if (nextPage) {
        [webHandler doRequest:nextPage andHeaders:nil andHTTPMethod:@"GET"];
    }

}

-(void)webServiceCallError:(NSError *)error{
    NSLog(@"Operation:%d, %@",currentOperation, error.description);
}

@end
