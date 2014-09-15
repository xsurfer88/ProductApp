//
//  ProductListViewController.h
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailViewController.h"

@interface ProductListViewController : UITableViewController <ProductListViewControllerDelegate>{
   
}

@property(nonatomic, strong) NSArray *products;

@end
