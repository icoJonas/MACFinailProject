//
//  WebServiceHandler.h
//  theMostAmazingFinalProject
//
//  Created by Mac on 5/28/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceHandler : NSObject

-(void)getCode;
-(void)getToken:(NSString *)CODE;

@end
