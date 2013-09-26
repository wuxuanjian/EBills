//
//  EBCalculateCell.m
//  EBills
//
//  Created by Woo on 13-4-29.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBCalculateCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation EBCalculateCell
@synthesize name,padMoney,padMoneyTitle,balanceMoney,balanceMoneyTitle;

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
