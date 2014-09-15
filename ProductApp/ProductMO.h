//
//  ProductMO.h
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductMO : NSObject



@property (nonatomic, copy) NSString *databaseName;
@property (nonatomic, retain, readonly) NSManagedObjectModel *model;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *coordinator;

@property (nonatomic, retain, readonly) NSManagedObjectContext *masterManagedContext;

+(ProductMO *)sharedInstance;

// File and URL Paths
- (NSString *)databaseFilePath;
- (NSURL *)databaseURLPath;

// Creating and Initializing
- (void)initWithDatabaseName:(NSString *)databaseName;
- (void)deleteEntity:(NSString *)entity;
@end


