//
//  Store.h
//  ProductApp
//
//  Created by Yang Zi on 9/15/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Store : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * productId;
@property (nonatomic, retain) NSNumber * colorId;
@property (nonatomic, retain) NSNumber * quantity;

@end
