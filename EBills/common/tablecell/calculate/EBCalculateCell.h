//
//  EBCalculateCell.h
//  EBills
//
//  Created by Woo on 13-4-29.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EBCalculateCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel* name;
@property (nonatomic,strong) IBOutlet UILabel* padMoney;//垫付
@property (nonatomic,strong) IBOutlet UILabel* padMoneyTitle;
@property (nonatomic,strong) IBOutlet UILabel* balanceMoney;//差额
@property (nonatomic,strong) IBOutlet UILabel* balanceMoneyTitle;

@end
