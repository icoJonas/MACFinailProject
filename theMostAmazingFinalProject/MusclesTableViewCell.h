//
//  MusclesTableViewCell.h
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusclesTableViewCell : UITableViewCell{
    IBOutlet UILabel *muscleName;
}

-(void)setupCellWithData:(NSDictionary *)muscle;

@end
