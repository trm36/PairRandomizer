//
//  CohortListViewController.m
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import "CohortListViewController.h"
#import "UIColor+Randomizer.h"
#import "UIView+FLKAutoLayout.h"
#import "Cohort.h"
#import "CohortController.h"
#import "Stack.h"
#import "CohortListTableViewDataSource.h"
#import "CohortDetailViewController.h"

@interface CohortListViewController () <UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CohortListTableViewDataSource *dataSource;

@end

@implementation CohortListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Cohorts";
    
    UIBarButtonItem *addCohortButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCohort)];
    self.navigationItem.rightBarButtonItem = addCohortButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataSource = [CohortListTableViewDataSource new];
    [self.dataSource registerTableView:self.tableView];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor devMountainBlue];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView alignTop:@"0" leading:@"0" bottom:@"0" trailing:@"0" toView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Bar Button Methods

- (void)addCohort {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Cohort?" message:@"Input a title for new cohort." preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Cohort Title";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Add Cohort" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        Cohort *cohort = [[CohortController sharedInstance] createCohort];
        cohort.name = ((UITextField *)alert.textFields[0]).text;
        [Stack save];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }]];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CohortDetailViewController *cohortDetailViewController = [CohortDetailViewController new];
    cohortDetailViewController.cohort = [CohortController sharedInstance].cohorts[indexPath.row];
    [self.navigationController pushViewController:cohortDetailViewController animated:YES];
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
