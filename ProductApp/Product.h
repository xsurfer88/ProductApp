//
//  Product.h
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * prodDescription;
@property (nonatomic, retain) NSNumber * regularPrice;
@property (nonatomic, retain) NSNumber * salePrice;
@property (nonatomic, retain) NSString * prodPhoto;
@property (nonatomic, retain) NSString * colors;
@property (nonatomic, retain) NSString * stores;

@end
