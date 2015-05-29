//
//  WebServiceHandler.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 5/28/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WebServiceHandler.h"

static NSString * const AUTH_REQUEST_URL = @"https://runkeeper.com/apps/authorize?response_type=code&client_id=21d211d3e8d04362bf4056eca118cca6&redirect_uri=http%3A%2F%2Fwww.google.com";

static NSString * const ACCESS_TOKEN_URL = @"https://runkeeper.com/apps/token?code=%@&client_id=%@&client_secret=%@&redirect_uri=http%3A%2F%2Fwww.google.com";

static NSString * const CLIENT_ID = @"21d211d3e8d04362bf4056eca118cca6";
static NSString * const CLIENT_SECRET = @"0951b34bcd594bf59f9ce64092b8ab67";

@implementation WebServiceHandler

-(void)getCode
{
    NSURL *urlRequest = [NSURL URLWithString:AUTH_REQUEST_URL];
    
    NSURLSession *mySession = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *myDataTask = [mySession dataTaskWithURL:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        else
        {
            NSLog(@"%@", data.description);
            NSLog(@"%@", response.description);
            
        }
    }];
    [myDataTask resume];
}

-(void)getToken:(NSString *)CODE
{
//    NSString *url = [NSString stringWithFormat:ACCESS_TOKEN_URL, CODE, CLIENT_ID, CLIENT_SECRET];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://runkeeper.com/apps/token?grant_type=authorization_code&code=%@&client_id=%@&client_secret=%@&redirect_uri=http%%3A%%2F%%2Fwww.google.com",CODE, CLIENT_ID, CLIENT_SECRET]]];
    request.timeoutInterval = 12;
    [request setHTTPMethod:@"POST"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (error==nil&&data&&[httpResponse statusCode]==200)
        {
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"%@",jsonObject);
            NSString *tokenType = [jsonObject objectForKey:@"token_type"];
            NSString *ACCESS_TOKEN = [jsonObject objectForKey:@"access_token"];
            
            //Store the token in the keychain
            [self storeToken:ACCESS_TOKEN ofType:tokenType];
        }
        else
        {
            NSLog(@"%@",error.description);
        }
    }];

}


@end
