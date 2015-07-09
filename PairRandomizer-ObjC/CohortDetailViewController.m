//
//  ViewController.m
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import "CohortDetailViewController.h"
#import "Pair.h"
#import "PairTableViewCell.h"
#import "UIColor+Randomizer.h"
#import "UIView+FLKAutoLayout.h"
#import "Cohort+Randomize.h"
#import "StudentListViewController.h"

static NSString *cellID = @"cellID";

@interface CohortDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *randomizedStudents;

@end

@implementation CohortDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.randomizedStudents = [self.cohort randomize];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [NSString stringWithFormat:@"DevMountain %@", self.cohort.name];
    
    UIToolbar *toolbar = [UIToolbar new];
    [self.view addSubview:toolbar];
    
    UIBarButtonItem *flex1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *editStudentsButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit Students" style:UIBarButtonItemStylePlain target:self action:@selector(editStudentsButtonTapped)];
    
    UIBarButtonItem *flex2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(randomize)];
    
    UIBarButtonItem *flex3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[flex1, editStudentsButton, flex2, reloadButton, flex3];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor devMountainBlue];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[PairTableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.tableView];
    
    //Constraints
    [toolbar alignLeading:@"0" trailing:@"0" toView:self.view];
    [toolbar alignBottomEdgeWithView:self.view predicate:@"0"];
    
    [self.tableView alignLeading:@"0" trailing:@"0" toView:self.view];
    [self.tableView alignTopEdgeWithView:self.view predicate:@"64"];
    [self.tableView constrainBottomSpaceToView:toolbar predicate:@"0"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.randomizedStudents = [self.cohort randomize];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIToolbar Button Methods

- (void)randomize {
    self.randomizedStudents = [self.cohort randomize];
    [self.tableView reloadData];
}

- (void)editStudentsButtonTapped {
    StudentListViewController *studentListViewController = [StudentListViewController new];
    studentListViewController.cohort = self.cohort;
    
    [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:studentListViewController] animated:YES completion:nil];
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.randomizedStudents.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PairTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Pair *pair = self.randomizedStudents[indexPath.section];
    
    cell.label1.text = pair.student1;
    cell.label2.text = pair.student2;
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 35;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

@end
