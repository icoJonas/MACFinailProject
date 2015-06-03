//
//  WebViewController.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/3/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UIWebView *wvWebView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(handleBack)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.wvWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.currentRecipe.strRecipeWebURL]]];
}

- (IBAction)btnBackPressed:(id)sender
{
    self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
