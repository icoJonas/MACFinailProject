//
//  WorkoutManagerDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceHandler.h"

@protocol WorkoutManagerDataSourceDelegate <NSObject>

@optional

-(void)catalogsUpdated;

@end

@interface WorkoutManagerDataSource : NSObject <WebServiceHandlerDelegate> {
    int currentOperation;
    int attempts;
    WebServiceHandler *webHandler;
}

@property (nonatomic, weak) id <WorkoutManagerDataSourceDelegate> delegate;

-(void)getCatalogs;

@end
