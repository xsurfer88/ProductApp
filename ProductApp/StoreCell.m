//
//  StoreCell.m
//  ProductApp
//
//  Created by Yang Zi on 9/15/14.
//  Copyright (c) 2014 Yang Zi. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell

@synthesize store, color, quantity;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
