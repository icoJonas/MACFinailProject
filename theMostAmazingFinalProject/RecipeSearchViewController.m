//
//  RecipeSearchViewController.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/1/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "RecipeSearchViewController.h"
#import "BackgroundViewHelper.h"
#import "AnimationHelper.h"
#import "BigOvenDataSource.h"
#import "SearchResultTableViewCell.h"
#import "RecipeSearchResult.h"
#import "RecipeViewController.h"
#import "ImageHelper.h"

@interface RecipeSearchViewController () <UISearchBarDelegate,BigOvenDataSourceDelegate,UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSMutableArray * searchResultsArray;
@property(nonatomic, strong) dispatch_queue_t myQueue;
@property(nonatomic, strong) BigOvenDataSource *bods;
@property (strong, nonatomic) IBOutlet UITableView *tableSearchResults;

@end

@implementation RecipeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchResultsArray = [NSMutableArray new];
    
//    self.tableSearchResults = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-300) style:UITableViewStylePlain];
    [self.tableSearchResults registerNib:[UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableSearchResults setHidden:true];
    
    _myQueue = dispatch_queue_create("myQueue", nil);
    
    self.bods = [[BigOvenDataSource alloc] init];
    self.bods.delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"User is searching for %@", searchBar.text);
    
    //Dismiss the keyboard
    [searchBar resignFirstResponder];
    
    //Animate the searchbar to the bottom of the screen
//    [AnimationHelper transitionView:searchBar toRect:CGRectMake(searchBar.frame.origin.x, self.view.frame.size.height-searchBar.frame.size.height, searchBar.frame.size.width, searchBar.frame.size.height) WithSpringWithDamping:1.8 andVelocity:0.5 andTransitionTime:1.0 andWaitTime:0.0];
    
    //Perform the request
    NSString *formattedSearchString = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [self.bods getRecipeSearch:formattedSearchString];
}


#pragma  mark - BigOvenDataSource delegate methods
-(void)returnSearchResults:(NSMutableArray *)arrSeachResults
{
    //Assign the class array
    self.searchResultsArray = [[NSMutableArray alloc] initWithArray:arrSeachResults];
    NSString *resultCount = [self.searchResultsArray lastObject];
    [self.searchResultsArray removeLastObject];
    
    //Load and present the table view
   dispatch_async(_myQueue, ^{
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableSearchResults reloadData];
       });
   });
//    [self.view addSubview:self.tableSearchResults];
    [self.tableSearchResults setHidden:false];
}

-(void)returnRecipe:(Recipe *)recipeObject
{
    //Load the new view with the recipe object
    RecipeViewController *rvc = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    rvc.recipeToDisplay = recipeObject;
//    [self presentViewController:rvc animated:YES completion:nil];
    [self.navigationController pushViewController:rvc animated:YES];
}

#pragma mark - TableView delegate and datasource methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultsArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 162;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //Load the data for the cell to display
    RecipeSearchResult *aSearchResult = [_searchResultsArray objectAtIndex:indexPath.row];
    
    //configure the cell
    cell.lblCategory.text = aSearchResult.strSearchCategory;
    cell.lblCuisine.text = aSearchResult.strSearchCuisine;
    cell.lblStarRating.text = aSearchResult.strSearchStarRating;
    cell.lblTitle.text = aSearchResult.strSearchTitle;
    cell.lblYield.text = [NSString stringWithFormat:@"%@ servings", aSearchResult.strSearchYieldNumber];
    [ImageHelper setImage:cell.imgRecipeImage120 FromPath:aSearchResult.strSearchImageURL120];
//    dispatch_async(self.myQueue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.imgRecipeImage120.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:aSearchResult.strSearchImageURL120]]];
//        });
//    });

    NSLog(@"Completed a cell object");
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //The user selected a recipe. Get that recipe
    RecipeSearchResult *lookThisUp = [self.searchResultsArray objectAtIndex:indexPath.row];
    [self.bods getRecipe:[lookThisUp.strSearchRecipeID intValue]];
}

@end
