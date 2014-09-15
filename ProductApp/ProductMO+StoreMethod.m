//
//  ProductMO+StoreMethod.m
//  ProductApp
//
//  Created by Yang Zi on 9/15/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductMO+StoreMethod.h"

@implementation ProductMO (StoreMethod)

- (void)insertStoreWithDictionary:(NSDictionary *)storeDict ByContext:(NSManagedObjectContext *) curContext{
    
    Store *store = [NSEntityDescription insertNewObjectForEntityForName:@"Store"
                                                     inManagedObjectContext:curContext];
    
    [store setId:[storeDict objectForKey:@"id"]];
    [store setName:[storeDict objectForKey:@"name"]];
    [store setProductId:[storeDict objectForKey:@"product_id"]];
    [store setColorId:[storeDict objectForKey:@"color_id"]];
    [store setQuantity:[storeDict objectForKey:@"quantity"]];
    
    NSError *error = nil;
    BOOL saved;
    saved = [curContext save:&error];
    if (!saved) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (NSArray *)getStoreByProdId:(NSNumber *)prodId ByContext:(NSManagedObjectContext *) curContext {
    NSArray *stores = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Store"];
    [request setSortDescriptors:[NSArray arrayWithObject:
                                 [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]]];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"productId == %d",[prodId integerValue]];
    [request setPredicate:pred];
    NSError *error = nil;
    
    stores = [curContext executeFetchRequest:request error:&error];
    
    return stores;
}

@end
