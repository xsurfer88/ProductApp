//
//  ProductViewController.m
//  ProductApp
//
//  Created by Yang Zi on 9/14/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductMO+ProductMethod.h"
#import "ProductMO+ColorMethod.h"
#import "ProductMO+StoreMethod.h"
#import "ProductListViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDictionary*)readFromJsonFile{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"product" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *jsonParsingError = nil;
    NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonParsingError];
    
    return jsonResults;
}

-(void)generateProducts:(NSDictionary *)jsonResults{
    NSMutableArray *results = jsonResults[@"products"];
    
    NSLog(@"product=%@", results);
    
    for (NSDictionary *prod in results){
        [[ProductMO sharedInstance]insertProductWithDictionary:prod ByContext:[[ProductMO sharedInstance] masterManagedContext]];
    }
}

-(void)generateColors:(NSDictionary *)jsonResults{
    NSMutableArray *results = jsonResults[@"colors"];
    
    NSLog(@"colors=%@", results);
    
    for (NSDictionary *color in results){
        [[ProductMO sharedInstance]insertColorWithDictionary:color ByContext:[[ProductMO sharedInstance] masterManagedContext]];
    }
}

-(void)generateStores:(NSDictionary *)jsonResults{
    NSMutableArray *results = jsonResults[@"stores"];
    
    NSLog(@"stores=%@", results);
    
    for (NSDictionary *store in results){
        [[ProductMO sharedInstance]insertStoreWithDictionary:store ByContext:[[ProductMO sharedInstance] masterManagedContext]];
    }
}

- (IBAction)createProduct:(id)sender {
    //clean up
    NSArray *entities = [[NSArray alloc] initWithObjects:@"Product", @"Color", @"Store", nil];
    
    for (NSString *entity in entities){
        [[ProductMO sharedInstance]deleteEntity:entity];
    }
    
    NSDictionary *jsonResults = [self readFromJsonFile];
    
    //create products
    [self generateProducts:jsonResults];
    
    //create colors
    [self generateColors:jsonResults];
    
    //create stores
    [self generateStores:jsonResults];
}

- (IBAction)showProduct:(id)sender {
    NSArray *products = [[ProductMO sharedInstance]getAllProducts:[[ProductMO sharedInstance] masterManagedContext]];
    
    ProductListViewController *productListViewController = [[ProductListViewController alloc] init];
    productListViewController.products = products;
    
    [self presentViewController:productListViewController animated:YES completion:nil];
}
@end
