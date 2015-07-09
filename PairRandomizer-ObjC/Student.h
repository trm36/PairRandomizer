//
//  Student.h
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Cohort;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Cohort *cohort;

@end
