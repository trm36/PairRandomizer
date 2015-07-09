//
//  CohortController.m
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import "CohortController.h"
@import CoreData;
#import "Stack.h"
#import "Student.h"

@interface CohortController()

@property (strong, nonatomic) NSArray *cohorts;

@end

@implementation CohortController

+ (CohortController *)sharedInstance {
    static CohortController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [CohortController new];
    });
    
    return sharedInstance;
}

- (Cohort *)createCohort {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Cohort" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
}

- (NSArray *)cohorts {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Cohort"];
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
}

- (void)deleteCohort:(Cohort *)cohort {
    [cohort.managedObjectContext deleteObject:cohort];
}

- (Student *)createStudentInCohort:(Cohort *)cohort {
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    student.cohort = cohort;
    
    return student;
}

- (void)deleteStudent:(Student *)student {
    [student.managedObjectContext deleteObject:student];
}


@end
