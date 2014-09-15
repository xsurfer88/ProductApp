//
//  ProductMO.m
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductMO.h"
#import <CoreData/CoreData.h>

@implementation ProductMO

#pragma mark - Properties

@synthesize databaseName = _fileName;
@synthesize model = _model;
@synthesize coordinator = _coordinator;
@synthesize masterManagedContext = _masterManagedContext;

#pragma mark - Singleton for class
+(ProductMO *)sharedInstance {
    static dispatch_once_t pred;
    static ProductMO *sharedInstance = nil;
    
    dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    return sharedInstance;
}

#pragma mark - Setting Main Core Data Properties.
// Lazily loads a model defined in Books.xcdatamodeld (a bundle directory
// containing RepTool.momd model file) that defines object-relational mapping
// between managed objects (instances of NSManagedObject) and SQLite database.
//
- (NSManagedObjectModel *)model
{
    if (_model == nil)
    {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *tPth;
        NSURL *modelURL;
        
        tPth = [bundle
                pathForResource:@"ProductModel" ofType:@"momd"];
        
        
        modelURL = [NSURL fileURLWithPath:tPth];
        _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
    }
    
    return _model;
}

// Lazily loads a controller responsible for storing and retreiving managed
// objects (instances of NSManagedObject) from SQLite database.
//
- (NSPersistentStoreCoordinator *)coordinator
{
    if (_coordinator)
        return _coordinator;
    
    
    NSError *error = nil;
    NSURL *storeURL = [self databaseURLPath];
    
    _coordinator = [[NSPersistentStoreCoordinator alloc]
                    initWithManagedObjectModel:[self model]];
    
    
    NSPersistentStore *store = [_coordinator
                                addPersistentStoreWithType:NSSQLiteStoreType
                                configuration:nil
                                URL:storeURL
                                options:nil
                                error:&error];
    if (store == nil)
    {
        NSLog(@"WARNING: Unable to create store with URL %@. Error was %@, %@",
                   storeURL, error, [error userInfo]);
    }
    
    return _coordinator;
}


#pragma mark - File and URL Paths

- (NSString *)databaseFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *dirPath = [paths lastObject];
    NSString *path = [dirPath stringByAppendingPathComponent:[self databaseName]];
    
    return [path stringByAppendingPathExtension:@"sqlite"];
}

- (NSURL *)databaseURLPath
{
    NSArray *URLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                           inDomains:NSUserDomainMask];
    NSURL *dirURL = [URLs lastObject];
    NSURL *URL = [dirURL URLByAppendingPathComponent:[self databaseName]];
    
    return [URL URLByAppendingPathExtension:@"sqlite"];
}

#pragma mark - Creating and Initializing

- (BOOL)databaseExists
{
    NSString *path = [self databaseFilePath];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:path
                                                isDirectory:NO];
}

- (void)initWithDatabaseName:(NSString *)databaseName
{
    self.databaseName = databaseName;
}

#pragma mark - Core Data stack

// Used to propegate saves to the persistent store (disk) without blocking the UI
- (NSManagedObjectContext *)masterManagedContext {
    if (_masterManagedContext != nil) {
        return _masterManagedContext;
    }
    
    NSPersistentStoreCoordinator *coord = [self coordinator];
    if (coord != nil) {
        _masterManagedContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _masterManagedContext.stalenessInterval = 0.0;
        [_masterManagedContext performBlockAndWait:^{
            [_masterManagedContext setPersistentStoreCoordinator:coord];
        }];
        
    }
    return _masterManagedContext;
}


#pragma mark - Storing
- (void)saveMasterContext {
    [self.masterManagedContext performBlock:^{
        NSError *error = nil;
        BOOL saved = [self.masterManagedContext save:&error];
        if (!saved) {
            // do some real error handling
            NSLog(@"Could not save master context due to %@", error);
        }
    }];
}



-(void)deleteEntity:(NSString *)entity {
    NSManagedObjectContext *tempContext = [ProductMO sharedInstance].masterManagedContext;
    
    [tempContext performBlockAndWait:^{
        
        NSFetchRequest *allRecs = [[NSFetchRequest alloc] init];
        [allRecs setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:tempContext]];
        
        [allRecs setIncludesPropertyValues:NO]; // only fetch managedObjectId;
        
        NSError *error = nil;
        NSArray *recs = [tempContext executeFetchRequest:allRecs error:&error];
        
        if (recs) {
            for (NSManagedObject *rec in recs) {
                [tempContext deleteObject:rec];
            }
            
            NSError *saveError = nil;
            if (![tempContext save:&saveError]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
        }
        [self saveMasterContext];
        
    }];
    
    
}


@end
