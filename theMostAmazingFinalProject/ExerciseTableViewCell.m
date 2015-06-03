//
//  ExerciseTableViewCell.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ExerciseTableViewCell.h"
#import "ImageHelper.h"

@implementation ExerciseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCellWithData:(NSDictionary *)exerciseDic{
    exerciseName.text = [exerciseDic objectForKey:@"name"];
    [ImageHelper setImage:exerciseImage FromPath:[exerciseDic objectForKey:@"image"]];
}

@end
