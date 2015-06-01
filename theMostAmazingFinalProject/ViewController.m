//
//  ViewController.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 28/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "ViewController.h"
#import "BackgroundViewHelper.h"

@interface ViewController ()
@property(strong,nonatomic) RunKeeperDataSource *runKeeperDataSource;
@property(strong,nonatomic) BigOvenDataSource *bigOvenDataSource;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"main tab";
    
    self.runKeeperDataSource = [RunKeeperDataSource new];
    self.bigOvenDataSource = [BigOvenDataSource new];
    
//    int recipeNumber = 466985; //recipeNumber will come from user input
//    [self.bigOvenDataSource getRecipe:recipeNumber];
    
//    [self.bigOvenDataSource getRecipeSearch:@"shrimp"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    //Comment out to disable RunKeeper authorization page from showing
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *responseURL = [NSString stringWithString:webView.request.URL.absoluteString];
    
    //Check if the string contains the keyword 'code'
    if ([responseURL containsString:@"code="])
    {
        //Code srting exists. Parse it
        
        NSString *haystack = [responseURL copy];
        NSString *prefix = @"https://www.google.com/?code=";
        NSString *suffix = @"&gws_rd=ssl";
        
        NSRange needleRange = NSMakeRange(prefix.length, haystack.length - prefix.length - suffix.length);
        
        NSString *code = [haystack substringWithRange:needleRange];
        [self.runKeeperDataSource getToken:code];
//        [self.runKeeperDataSource getFitnessActivities];
//        [self.runKeeperDataSource getUser];
//        [self.runKeeperDataSource getProfile];
//        [self.runKeeperDataSource postFitnessActivity];
//        [self.runKeeperDataSource getSleepFeed];
//        [self.runKeeperDataSource getSleepActivity:@"548678686"];
//        [self.runKeeperDataSource postSleepActivity:nil];
        [webView removeFromSuperview];
    }
}

@end
