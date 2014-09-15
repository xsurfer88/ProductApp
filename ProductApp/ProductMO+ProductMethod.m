//
//  ProductMO+ProductMethod.m
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductMO+ProductMethod.h"

@implementation ProductMO (ProductMethod)

- (void)insertProductWithDictionary:(NSDictionary *)prodDict ByContext:(NSManagedObjectContext *) curContext{
   
    Product *product = [NSEntityDescription insertNewObjectForEntityForName:@"Product"
                                             inManagedObjectContext:curContext];
    
    [product setId:[prodDict objectForKey:@"id"]];
    [product setName:[prodDict objectForKey:@"name"]];
    [product setProdDescription:[prodDict objectForKey:@"prod_description"]];
    [product setRegularPrice:[prodDict objectForKey:@"regular_price"]];
    [product setSalePrice:[prodDict objectForKey:@"sale_price"]];
    [product setProdPhoto:[prodDict objectForKey:@"prod_photo"]];
    
    NSError *error = nil;
    BOOL saved;
    saved = [curContext save:&error];
    if (!saved) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}

- (Product *)getProductById:(NSNumber *)id ByContext:(NSManagedObjectContext *) curContext {
    NSArray *products = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Product"];
    [request setSortDescriptors:[NSArray arrayWithObject:
                                 [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]]];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"id == %d",[id integerValue]];
    [request setPredicate:pred];
    NSError *error = nil;
    
    products = [curContext executeFetchRequest:request error:&error];
    Product *fetchedProduct = [products lastObject];
    
    
    return fetchedProduct;
}

- (NSArray *)getAllProducts:(NSManagedObjectContext *)curContext {
    NSArray *products = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Product"];
    [request setSortDescriptors:[NSArray arrayWithObject:
                                 [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    NSError *error = nil;
    
    products = [curContext executeFetchRequest:request error:&error];
    
    return products;
}

-(void)deleteProduct:(NSString*)productId
{
    NSManagedObjectContext *tempContext = [ProductMO sharedInstance].masterManagedContext;
        
        NSFetchRequest *allRecs = [[NSFetchRequest alloc] init];
        [allRecs setEntity:[NSEntityDescription entityForName:@"Product" inManagedObjectContext:tempContext]];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"id == %@",productId];
        [allRecs setPredicate:pred];
        
        
        [allRecs setIncludesPropertyValues:NO];
        
        
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
    
        //delete from stores for productId
        [allRecs setEntity:[NSEntityDescription entityForName:@"Store" inManagedObjectContext:tempContext]];
        pred = [NSPredicate predicateWithFormat:@"productId == %@",productId];
        [allRecs setPredicate:pred];
    
        [allRecs setIncludesPropertyValues:NO];
    
        error = nil;
        recs = [tempContext executeFetchRequest:allRecs error:&error];
        
        if (recs) {
            for (NSManagedObject *rec in recs) {
                [tempContext deleteObject:rec];
            }
            
            NSError *saveError = nil;
            if (![tempContext save:&saveError]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
        }

}

-(void)updateProductWithDictionary:(NSDictionary *)curDict {
    NSManagedObjectContext *tempContext = [ProductMO sharedInstance].masterManagedContext;
    [tempContext performBlockAndWait:^{
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Product"];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"name == %@",[curDict objectForKey:@"name"]];
        [request setPredicate:pred];
        NSError *error = nil;
        
        NSArray *products = [tempContext executeFetchRequest:request error:&error];
        Product * product = [products lastObject];
        
        [product setName:[curDict objectForKey:@"name"]];
        [product setProdDescription:[curDict objectForKey:@"prod_description"]];
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        [product setRegularPrice:[f numberFromString:[curDict objectForKey:@"regular_price"]]];
        [product setSalePrice:[f numberFromString:[curDict objectForKey:@"sale_price"]]];
        
        BOOL saved;
        saved = [tempContext save:&error];
        if (!saved) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
    }];
    
}

@end
