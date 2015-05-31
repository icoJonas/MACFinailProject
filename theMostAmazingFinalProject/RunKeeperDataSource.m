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
    GET_FITNES_ACTIVITY_DETAIL = 4,
    GET_FITNESS_ACTIVITY_SUMMARY = 5,
    GET_PROFILE = 6,
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

-(void)getFitnessActivities
{
    currentOperation = GET_FITNESS_ACTIVITIES;
    
    //Get the token from the keychain to form the header
    NSString *AUTH_TOKEN = [KeychainHelper getToken];
    NSLog(@"The retrieved token is %@", AUTH_TOKEN);
    //Form the header
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"Bearer %@", AUTH_TOKEN], @"Authorization", @"application/vnd.com.runkeeper.FitnessActivityFeed+json", @"Accept", nil];
    [webHandler doRequest:@"http://api.runkeeper.com/fitnessActivities" andHeaders:headers andHTTPMethod:@"GET"];
}

-(void)getUser
{
    currentOperation = GET_USER;
    //Get the token
    NSString *AUTH_TOKEN = [KeychainHelper getToken];
    NSLog(@"The retrieved token is %@", AUTH_TOKEN);
    //Form the header
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"Bearer %@", AUTH_TOKEN], @"Authorization", @"application/vnd.com.runkeeper.User+json", @"Accept", nil];
    
    [webHandler doRequest:@"http://api.runkeeper.com/user/" andHeaders:headers andHTTPMethod:@"GET"];
}

-(void)getProfile
{
    currentOperation = GET_PROFILE;
    //Get the token
    NSString *AUTH_TOKEN = [KeychainHelper getToken];
    NSLog(@"The retrieved token is %@", AUTH_TOKEN);
    //Form the header
    NSDictionary *headers = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"Bearer %@", AUTH_TOKEN], @"Authorization", @"application/vnd.com.runkeeper.Profile+json", @"Accept", nil];
    
    [webHandler doRequest:@"http://api.runkeeper.com/profile/" andHeaders:headers andHTTPMethod:@"GET"];
}

#pragma mark - WebServiceHandler delegate methods

-(void)webServiceCallFinished:(id)data
{
    NSError *error;
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"There was an error parsing the RunKeeper JSON file");
    }
    else if (currentOperation == GET_TOKEN) {
        NSString *tokenType = [jsonObject objectForKey:@"token_type"];
        NSString *ACCESS_TOKEN = [jsonObject objectForKey:@"access_token"];
        NSLog(@"%@",tokenType);
        NSLog(@"%@",ACCESS_TOKEN);
        [KeychainHelper storeTheToken:ACCESS_TOKEN];
        
        NSLog(@"The token is: %@", [KeychainHelper getToken]);
    }
    else if (currentOperation == GET_FITNESS_ACTIVITIES)
    {
        NSMutableArray *arrFitnessActivities = [[NSMutableArray alloc] init];
        
        for (NSDictionary *aFitnessActivityDict in [jsonObject objectForKey:@"items"])
        {
            FitnessActivity *aFitnessActivity = [[FitnessActivity alloc] initWithJSONDict:aFitnessActivityDict];
            [arrFitnessActivities addObject:aFitnessActivity];
            
        }
    }
    else if (currentOperation == GET_USER)
    {
        //User object contains URIs needed for other calls.
        RunKeeperUser *rkUser = [[RunKeeperUser alloc] initWithJSONDict:jsonObject];
        
    }
    else if (currentOperation == GET_PROFILE)
    {
        //Profile object contains user personal information and location
        RunKeeperProfile *rkProfile = [[RunKeeperProfile alloc] initWithJSONDict:jsonObject];
    }
}

-(void)webServiceCallError:(NSError *)error
{
    NSLog(@"%@",error.description);
}


@end
