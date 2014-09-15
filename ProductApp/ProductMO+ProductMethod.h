//
//  ProductMO+ProductMethod.h
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductMO.h"
#import "Product.h"

@interface ProductMO (ProductMethod)

- (void)insertProductWithDictionary:(NSDictionary *)prodDict ByContext:(NSManagedObjectContext *) curContext;
- (Product *)getProductById:(NSNumber *)id ByContext:(NSManagedObjectContext *) curContext;
- (NSArray *)getAllProducts:(NSManagedObjectContext *) curContext;
-(void)deleteProduct:(NSNumber*)productId;
-(void)updateProductWithDictionary:(NSDictionary *)curDict;
@end
