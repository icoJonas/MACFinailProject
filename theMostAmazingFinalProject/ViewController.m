//
//  ViewController.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
@property(strong,nonatomic) WebServiceHandler *wsh;
@property (strong, nonatomic) IBOutlet UIWebView *wvWebView;
@end

static NSString * const AUTH_REQUEST_URL = @"https://runkeeper.com/apps/authorize?response_type=code&client_id=21d211d3e8d04362bf4056eca118cca6&redirect_uri=http%3A%2F%2Fwww.google.com";


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.wsh = [WebServiceHandler new];
    
    [self.wsh getCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.wvWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:AUTH_REQUEST_URL]]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%@", webView.request.URL.absoluteString);
    NSString *responseURL = [NSString stringWithString:webView.request.URL.absoluteString];
    
    //Check if the string contains the keyword 'code'
    if ([responseURL containsString:@"code="])
    {
        NSLog(@"Code srting exists. Parse it");
        
        NSString *haystack = [responseURL copy];
        NSString *prefix = @"https://www.google.com/?code=";
        NSString *suffix = @"&gws_rd=ssl";
        
        NSRange needleRange = NSMakeRange(prefix.length, haystack.length - prefix.length - suffix.length);
        
        NSString *code = [haystack substringWithRange:needleRange];
        NSLog(@"code: %@", code.description);
        
        [self.wsh getToken:code];
    }
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSString *nextURL = webView.request.URL.absoluteString;
//    if ([nextURL containsString:@"code="]){
//        nextURL = [nextURL stringByReplacingOccurrencesOfString:@"https://www.google.com/?code=" withString:@""];
//        code = [nextURL stringByReplacingOccurrencesOfString:@"&gws_rd=ssl" withString:@""];
//        [contentWebView removeFromSuperview];
//        [self doARequest];
//    }
//}


@end
