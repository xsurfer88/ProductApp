//
//  ProductMO+StoreMethod.h
//  ProductApp
//
//  Created by Yang Zi on 9/15/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductMO.h"
#import "Store.h"

@interface ProductMO (StoreMethod)

- (void)insertStoreWithDictionary:(NSDictionary *)storeDict ByContext:(NSManagedObjectContext *) curContext;
- (NSArray *)getStoreByProdId:(NSNumber *)prodId ByContext:(NSManagedObjectContext *) curContext;

@end
