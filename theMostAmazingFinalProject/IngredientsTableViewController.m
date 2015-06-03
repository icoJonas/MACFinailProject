//
//  IngredientsTableViewController.m
//  theMostAmazingFinalProject
//
//  Created by Mac on 6/2/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "IngredientsTableViewController.h"
#import "BackgroundViewHelper.h"

@interface IngredientsTableViewController ()

@property (nonatomic, strong) NSMutableArray *arrIngrdients;
@property (nonatomic, strong) NSMutableArray *arrIngredientStrings;

@end

@implementation IngredientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self loadIngredients];
    
    //Register the cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    //Add a touch gesture to the view to dismiss view
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finished)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
    [self.view addGestureRecognizer:tapGesture];
}

-(void)finished
{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrIngredientStrings.count;
}

-(void)loadIngredients
{
    self.arrIngrdients = [[NSMutableArray alloc] initWithArray:self.currentRecipe.arrRecipeIngredients];
    
    self.arrIngredientStrings = [[NSMutableArray alloc] init];
    //Extract ingredients from array of disctionaries into array of strings
    for (NSDictionary *anIngredient in self.arrIngrdients) {
        NSString *quantity = [anIngredient objectForKey:@"DisplayQuantity"];
        NSString *name = [anIngredient objectForKey:@"Name"];
        NSString *quantityUnit = [anIngredient objectForKey:@"Unit"];
        NSString *metricUnit = [anIngredient objectForKey:@"MetricUnit"];
        NSString *metricQuantity = [anIngredient objectForKey:@"MetricDisplayQuantity"];
        
        NSString *ingredientString = [NSString stringWithFormat:@"%@ %@ (%@ %@) %@", quantity, quantityUnit, metricQuantity, metricUnit, name];
        
        [self.arrIngredientStrings addObject:ingredientString];
    }
    
    //Ingredient strings have been parsed from dictionary.
    //Load the data into the table view cell
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    // Configure the cell...
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    cell.detailTextLabel.backgroundColor = [UIColor colorWithWhite:05. alpha:0.3];
    
    cell.textLabel.text = [self.arrIngredientStrings objectAtIndex:indexPath.row];
    
    NSDictionary *ingredientInfo = [[self.arrIngrdients objectAtIndex:indexPath.row] objectForKey:@"IngredientInfo"];
    if ([ingredientInfo isKindOfClass:[NSDictionary class]])
    {
        cell.detailTextLabel.text = [ingredientInfo objectForKey:@"Department"];
    }
    else
    {
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
