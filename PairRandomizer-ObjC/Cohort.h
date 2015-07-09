//
//  Cohort.h
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Cohort : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSOrderedSet *students;
@end

@interface Cohort (CoreDataGeneratedAccessors)

- (void)insertObject:(Student *)value inStudentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromStudentsAtIndex:(NSUInteger)idx;
- (void)insertStudents:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeStudentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInStudentsAtIndex:(NSUInteger)idx withObject:(Student *)value;
- (void)replaceStudentsAtIndexes:(NSIndexSet *)indexes withStudents:(NSArray *)values;
- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSOrderedSet *)values;
- (void)removeStudents:(NSOrderedSet *)values;
@end
