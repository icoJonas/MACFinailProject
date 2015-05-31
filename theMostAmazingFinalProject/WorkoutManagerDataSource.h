//
//  WorkoutManagerDataSource.h
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 30/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceHandler.h"

@interface WorkoutManagerDataSource : NSObject <WebServiceHandlerDelegate> {
    int currentOperation;
    WebServiceHandler *webHandler;
}

-(void)getCatalogs;

@end
