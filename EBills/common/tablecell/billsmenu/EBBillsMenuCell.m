//
//  EBBillsMenuCell.m
//  EBills
//
//  Created by umessage on 13-4-17.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBBillsMenuCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation EBBillsMenuCell
@synthesize name;
@synthesize date;
@synthesize plain;
@synthesize people;
@synthesize rectView;
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


-(void) shoeCell:(EBBillModel*)model
{
    self.rectView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.rectView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.rectView.layer.shadowOpacity = 0.4;
    self.rectView.layer.shadowRadius = 1.0;
    
    if(model && model != nil)
    {
        self.name.text = model.billName;
        self.date.text = model.billDate;
        self.people.text = model.billPeople;
        self.plain.text = model.billDetails;
    }
}

@end
