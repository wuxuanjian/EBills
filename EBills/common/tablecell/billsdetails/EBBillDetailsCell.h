//
//  EBBillDetailsCell.h
//  EBills
//
//  Created by umessage on 13-4-17.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EBBillDetailsModel.h"

@interface EBBillDetailsCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel* name;
@property (nonatomic,strong) IBOutlet UILabel* money;
@property (nonatomic,strong) IBOutlet UILabel* people;
@property (nonatomic,strong) IBOutlet UILabel* date;
@property (nonatomic,strong) IBOutlet UILabel* plain;
@property (nonatomic,strong) IBOutlet UIView*  rectView;

-(void) showCell:(EBBillDetailsModel*)model;
@end
