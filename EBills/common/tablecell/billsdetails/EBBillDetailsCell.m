//
//  EBBillDetailsCell.m
//  EBills
//
//  Created by umessage on 13-4-17.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBBillDetailsCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation EBBillDetailsCell
@synthesize name,people,plain,date,money,rectView;

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

-(void) showCell:(EBBillDetailsModel*)model
{
    self.rectView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.rectView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.rectView.layer.shadowOpacity = 0.4;
    self.rectView.layer.shadowRadius = 1.0;
    if(model != nil)
    {
        self.name.text = model.detailsEvent;
        self.people.text = model.detailsPeople;
        self.money.text = model.detailsMoney;
        self.date.text = model.detailsDate;
        self.plain.text = model.detailsExPlain;
    }
}

@end
