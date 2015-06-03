//
//  WorkoutViewController.h
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutManagerDataSource.h"
#import "OBShapedButton.h"

@interface WorkoutViewController : UIViewController{
    IBOutlet UIActivityIndicatorView *activityView;
    IBOutlet OBShapedButton *scheduleButton;
    IBOutlet OBShapedButton *exerciseButton;
}

@property(strong,nonatomic) WorkoutManagerDataSource *wgerDataSource;

@end
