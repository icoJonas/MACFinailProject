//
//  WorkoutViewController.m
//  theMostAmazingFinalProject
//
//  Created by Luis Jonathan Godoy Marín on 31/05/15.
//  Copyright (c) 2015 MAC. All rights reserved.
//

#import "WorkoutViewController.h"
#import "BackgroundViewHelper.h"
#import "MusclesTableViewCell.h"
#import "wgerSQLiteDataSource.h"

@interface WorkoutViewController () <WorkoutManagerDataSourceDelegate>

@end

@implementation WorkoutViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Workout";
        muscles = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.wgerDataSource = [WorkoutManagerDataSource new];
    self.wgerDataSource.delegate = self;
    [self.wgerDataSource getCatalogs];
    [muscleTableView registerNib:[UINib nibWithNibName:@"MusclesTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [activityView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [BackgroundViewHelper getSharedInstance].assignedView = self.view;
    [[BackgroundViewHelper getSharedInstance] start];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - WorkoutManagerDataSourceDelegate methods

-(void)catalogsUpdated{
    [activityView stopAnimating];
    wgerSQLiteDataSource *dataSource = [wgerSQLiteDataSource new];
    [muscles addObjectsFromArray:[dataSource getMuscles]];
    [muscleTableView reloadData];
}

#pragma mark - UITableView DataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return muscles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    NSDictionary *muscleDic = [muscles objectAtIndex:indexPath.row];
    MusclesTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setupCellWithData:muscleDic];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67.0;
}

#pragma mark - UITableView Delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *muscleDic = [muscles objectAtIndex:indexPath.row];
    NSLog(@"%@",muscleDic);
//    NewsDetailViewController *newsDetailVC = [[NewsDetailViewController alloc] init];
//    newsDetailVC.newsData = newsDic;
//    [self.navigationController pushViewController:newsDetailVC animated:YES];
}


@end
