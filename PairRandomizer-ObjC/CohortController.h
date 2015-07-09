//
//  CohortController.h
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cohort.h"

@interface CohortController : NSObject

+ (CohortController *)sharedInstance;

- (Cohort *)createCohort;

@property (strong, nonatomic, readonly) NSArray *cohorts;

- (void)deleteCohort:(Cohort *)cohort;

- (Student *)createStudentInCohort:(Cohort *)cohort;

- (void)deleteStudent:(Student *)student;

@end
