//
//  wgerSQLiteDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "wgerSQLiteDataSource.h"

@implementation wgerSQLiteDataSource

-(void)insertAllNewCategories:(NSArray *)categories{
    for (NSDictionary *category in categories) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_category_catalog WHERE id = %d", [[category objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_category_catalog" andData:category];
        }
    }
}

-(void)insertAllNewEquipments:(NSArray *)equipments{
    for (NSDictionary *equipment in equipments) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_equipment_catalog WHERE id = %d", [[equipment objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_equipment_catalog" andData:equipment];
        }
    }
}

-(void)insertAllNewMuscles:(NSArray *)muscles{
    for (NSDictionary *muscle in muscles) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_muscle_catalog WHERE id = %d", [[muscle objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_muscle_catalog" andData:muscle];
        }
    }
}


-(void)insertAllNewExercises:(NSArray *)exercises{
    for (NSDictionary *exercise in exercises) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_exercise_catalog WHERE id = %d", [[exercise objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_exercise_catalog" andData:exercise];
        }
    }
}

-(void)insertMuscles:(NSArray *)muscles ForExercise:(int)exercise{
    for (NSNumber *muscle in muscles) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id_muscle FROM wger_exercise_muscle WHERE id_muscle = %d AND id_exercise = %d", [muscle intValue], exercise]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_exercise_muscle" andData:[NSDictionary dictionaryWithObjects:@[muscle, [NSNumber numberWithInt:exercise]] forKeys:@[@"id_muscle", @"id_exercise"]]];
        }
    }
}

-(void)insertEquipments:(NSArray *)equipments ForExercise:(int)exercise {
    for (NSNumber *equipment in equipments) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id_equipment FROM wger_exercise_equipment WHERE id_equipment = %d AND id_exercise = %d", [equipment intValue], exercise]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_exercise_equipment" andData:[NSDictionary dictionaryWithObjects:@[equipment, [NSNumber numberWithInt:exercise]] forKeys:@[@"id_equipment", @"id_exercise"]]];
        }
    }
}

-(void)insertAllNewImages:(NSArray *)images{
    for (NSDictionary *image in images) {
        NSArray *currentElements = [self executeQuery:[NSString stringWithFormat:@"SELECT id FROM wger_image_exercise WHERE id = %d", [[image objectForKey:@"id"] intValue]]];
        if (currentElements.count == 0) {
            [self executeInsertOperation:@"wger_image_exercise" andData:image];
        }
    }
}

-(NSArray *)getMuscles{
    return [self executeQuery:@"SELECT * FROM wger_muscle_catalog"];
}

-(NSArray *)getExercisesForMuscle:(NSNumber *)muscleId{
    return [self executeQuery:[NSString stringWithFormat:@"SELECT ex.name FROM wger_exercise_catalog ex, wger_exercise_muscle mus  WHERE mus.id_muscle = %d AND ex.language = 2;",muscleId.intValue]];
}

@end
