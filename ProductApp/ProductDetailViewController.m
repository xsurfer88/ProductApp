//
//  ProductDetailViewController.m
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductMO+ProductMethod.h"
#import "ProductMO+StoreMethod.h"
#import "ProductMO+ColorMethod.h"
#import "StoreCell.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

@synthesize product, productName;
@synthesize prodDescription, regularPrice, salePrice, photo;
@synthesize availability;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *img = [UIImage imageNamed:product.prodPhoto];
    photo.image = img;
    productName.text = product.name;
    prodDescription.text = product.prodDescription;
    regularPrice.text = [NSString stringWithFormat:@"%@", product.regularPrice ];
    salePrice.text = [NSString stringWithFormat:@"%@",product.salePrice];
    
    stores = [[ProductMO sharedInstance]getStoreByProdId:product.id ByContext:[[ProductMO sharedInstance]masterManagedContext]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)updateTapped:(id)sender {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:product.name forKey:@"name"];
    [dict setObject:prodDescription.text forKey:@"prod_description"];
    [dict setObject:regularPrice.text forKey:@"regular_price"];
    [dict setObject:salePrice.text forKey:@"sale_price"];
    
    [[ProductMO sharedInstance]updateProductWithDictionary:dict];
    [delegate refresh];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteTapped:(id)sender {
    [[ProductMO sharedInstance]deleteProduct:product.id];
    [delegate refresh];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [stores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StoreCell";
    if (!storeNibRegistered) {
        UINib *nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        storeNibRegistered = YES;
        
    }

    StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Store *store = [stores objectAtIndex:indexPath.row];
    
    cell.store.text = store.name;
    Color *color = [[ProductMO sharedInstance] getColorById:store.colorId ByContext:[[ProductMO sharedInstance]masterManagedContext]];
    cell.color.text = color.name;
    cell.quantity.text = [NSString stringWithFormat:@"%@", store.quantity];
    
    return cell;
}

@end
