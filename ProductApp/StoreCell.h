//
//  StoreCell.h
//  ProductApp
//
//  Created by Yang Zi on 9/15/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *store;
@property (strong, nonatomic) IBOutlet UILabel *color;
@property (strong, nonatomic) IBOutlet UILabel *quantity;
@end
