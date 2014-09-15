//
//  ProductMO+ColorMethod.h
//  ProductApp
//
//  Created by Yang Zi on 9/15/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductMO.h"
#import "Color.h"

@interface ProductMO (ColorMethod)

- (void)insertColorWithDictionary:(NSDictionary *)colorDict ByContext:(NSManagedObjectContext *) curContext;
- (Color *)getColorById:(NSNumber *)colorId ByContext:(NSManagedObjectContext *) curContext;
@end
