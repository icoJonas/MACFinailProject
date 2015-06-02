//
//  MusclesTableViewCell.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "MusclesTableViewCell.h"

@implementation MusclesTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupCellWithData:(NSDictionary *)muscle{
    muscleName.text = [muscle objectForKey:@"name"];
}

@end
