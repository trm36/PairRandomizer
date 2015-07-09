//
//  Stack.h
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface Stack : NSObject

+ (Stack *)sharedInstance;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

+ (void)save;

@end