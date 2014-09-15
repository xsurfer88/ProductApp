//
//  ProductDetailViewController.h
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Store.h"
#import "Color.h"

@protocol ProductListViewControllerDelegate <NSObject>

- (void)refresh;

@end

@interface ProductDetailViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
     id<ProductListViewControllerDelegate>delegate;
    
     NSArray *stores;
     BOOL storeNibRegistered;
}

@property (nonatomic, strong) id<ProductListViewControllerDelegate>delegate;
@property (nonatomic, strong) Product *product;

@property (strong, nonatomic) IBOutlet UITextField *prodDescription;
@property (strong, nonatomic) IBOutlet UITextField *regularPrice;
@property (strong, nonatomic) IBOutlet UITextField *salePrice;

@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UITableView *availability;
@property (strong, nonatomic) IBOutlet UIImageView *photo;

- (IBAction)goBack:(id)sender;
- (IBAction)updateTapped:(id)sender;
- (IBAction)deleteTapped:(id)sender;
@end
