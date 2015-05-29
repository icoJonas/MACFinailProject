//
//  RunKeeperDataSource.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RunKeeperDataSource.h"
#import "KeychainHelper.h"

static NSString * const AUTH_REQUEST_URL = @"https://runkeeper.com/apps/authorize?response_type=code&client_id=21d211d3e8d04362bf4056eca118cca6&redirect_uri=http%3A%2F%2Fwww.google.com";

static NSString * const ACCESS_TOKEN_URL = @"https://runkeeper.com/apps/token?code=%@&client_id=%@&client_secret=%@&redirect_uri=http%3A%2F%2Fwww.google.com";

static NSString * const CLIENT_ID = @"21d211d3e8d04362bf4056eca118cca6";
static NSString * const CLIENT_SECRET = @"0951b34bcd594bf59f9ce64092b8ab67";

@implementation RunKeeperDataSource

enum OPERATIONS {
    GET_TOKEN = 1,
    GET_USER = 2,
    GET_FITNESS_ACTIVITIES = 3,
};

-(instancetype)init{
    self = [super init];
    if (self) {
        currentOperation = 0;
        webHandler = [[WebServiceHandler alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - Public methods

-(void)getToken:(NSString *)CODE
{
    currentOperation = GET_TOKEN;
    [webHandler doRequest:[NSString stringWithFormat:@"https://runkeeper.com/apps/token?grant_type=authorization_code&code=%@&client_id=%@&client_secret=%@&redirect_uri=http%%3A%%2F%%2Fwww.google.com",CODE, CLIENT_ID, CLIENT_SECRET] andHeaders:nil andHTTPMethod:@"POST"];
}

-(void)getFitnessActivities{
    currentOperation = GET_FITNESS_ACTIVITIES;
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:@"Bearer 3205693701f44eab893db341ae9e2f44", @"Authorization", @"application/vnd.com.runkeeper.FitnessActivityFeed+json", @"Accept", nil];
    [webHandler doRequest:@"http://api.runkeeper.com/fitnessActivities" andHeaders:headers andHTTPMethod:@"GET"];
}

#pragma mark - WebServiceHandler delegate methods

-(void)webServiceCallFinished:(id)data{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if (currentOperation == GET_TOKEN) {
        NSString *tokenType = [jsonObject objectForKey:@"token_type"];
        NSString *ACCESS_TOKEN = [jsonObject objectForKey:@"access_token"];
        NSLog(@"%@",tokenType);
        NSLog(@"%@",ACCESS_TOKEN);
        [KeychainHelper storeTheToken:ACCESS_TOKEN];
    }
}

-(void)webServiceCallError:(NSError *)error{
    NSLog(@"%@",error.description);
}


@end
