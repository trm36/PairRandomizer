//
//  CohortListTableViewDataSource.m
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import "CohortListTableViewDataSource.h"
#import "CohortController.h"
#import "Cohort.h"
#import "Stack.h"

static NSString *cellID = @"cellID";

@implementation CohortListTableViewDataSource

- (void)registerTableView:(UITableView *)tableView
{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CohortController sharedInstance].cohorts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.backgroundColor = [UIColor blackColor];
    
    Cohort *cohort = [CohortController sharedInstance].cohorts[indexPath.row];
    
    cell.textLabel.text = cohort.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Cohort *cohort = [CohortController sharedInstance].cohorts[indexPath.row];
    [[CohortController sharedInstance] deleteCohort:cohort];
    [Stack save];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}



















@end
