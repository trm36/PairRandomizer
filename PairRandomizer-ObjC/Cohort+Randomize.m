//
//  Cohort+Randomize.m
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import "Cohort+Randomize.h"
#import "Pair.h"
#import "Student.h"

@implementation Cohort (Randomize)

- (NSArray *)randomize {
    
    
    NSMutableArray *studentStringArray = [NSMutableArray new];
    
    for (Student *student in self.students) {
        [studentStringArray addObject:student.name];
    }
    
    NSMutableArray *shuffledStudentPairsArray = [NSMutableArray new];
    
    while (studentStringArray.count > 0) {
        Pair *pair = [Pair new];
        
        NSInteger index = arc4random_uniform((u_int32_t)studentStringArray.count);
        pair.student1 = studentStringArray[index];
        [studentStringArray removeObjectAtIndex:index];
        
        
        if (studentStringArray.count != 0) {
            NSInteger index = arc4random_uniform((u_int32_t)studentStringArray.count);
            pair.student2 = studentStringArray[index];
            [studentStringArray removeObjectAtIndex:index];
        } else {
            pair.student2 = @"Mentor";
        }
        
        [shuffledStudentPairsArray addObject:pair];
    }
    
    return [shuffledStudentPairsArray copy];
}

@end
