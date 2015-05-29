//
//  WebServiceHandler.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 5/28/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WebServiceHandler.h"

@implementation WebServiceHandler

#pragma mark
#pragma mark  Initialization Methods

-(id)initWithDelegate:(id <WebServiceHandlerDelegate>)del
{
    self = [super init];
    if(self)
    {
        delegate = del;
    }
    return self;
}

#pragma mark
#pragma mark  Public Methods

-(void)doRequest:(NSString *)urlSite andHeaders:(NSDictionary *)headers andHTTPMethod:(NSString *)method{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlSite]];
    if (headers) {
        [self setHeaders:headers forRequest:request];
    }
    request.timeoutInterval = 12;
    [request setHTTPMethod:method];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
         if (error==nil&&data&&[httpResponse statusCode]==200) {
             [delegate webServiceCallFinished:data];
         } else {
             [delegate webServiceCallError:error];
         }
     }];
}

-(void)setHeaders:(NSDictionary *)headers forRequest:(NSMutableURLRequest *)resquest{
    for (NSString *key in headers.allKeys) {
        [resquest setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
}

@end