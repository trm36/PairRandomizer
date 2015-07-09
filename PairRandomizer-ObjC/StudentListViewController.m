//
//  StudentListViewController.m
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import "StudentListViewController.h"
#import "UIColor+Randomizer.h"
#import "CohortController.h"
#import "Stack.h"
#import "Student.h"

static NSString *cellID = @"cellID";

@interface StudentListViewController() <UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"Edit %@", self.cohort.name];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
    self.navigationItem.leftBarButtonItem = doneButton;
    
    UIBarButtonItem *addStudentButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addStudentButtonTapped)];
    self.navigationItem.rightBarButtonItem = addStudentButton;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor devMountainBlue];
    self.tableView.dataSource = self;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:self.tableView];
}

#pragma mark - Bar Button Methods

- (void)doneButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addStudentButtonTapped {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add Student?" message:@"Input a name for new student." preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Student Name";
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Add Student" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        Student *student = [[CohortController sharedInstance] createStudentInCohort:self.cohort];
        student.name = ((UITextField *)alert.textFields[0]).text;
        [Stack save];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }]];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cohort.students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    
    Student *student = self.cohort.students[indexPath.row];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = student.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Student *student = self.cohort.students[indexPath.row];
        [[CohortController sharedInstance] deleteStudent:student];
        [Stack save];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
