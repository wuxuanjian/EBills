//
//  EBCalculateViewController.h
//  EBills
//
//  Created by Woo on 13-4-27.
//  Copyright (c) 2013年 umessage. All rights reserved.
//  结算金额

#import <UIKit/UIKit.h>
#import "EBBillModel.h"

@interface EBCalculateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView*    ebTabelView;
@property (nonatomic,strong) IBOutlet UILabel*        ebMoneyLabel;
@property (nonatomic,strong) IBOutlet UILabel*        ebMeanMoneyLabel;
@property (nonatomic,strong) IBOutlet UIView*         titleView;
@property (nonatomic,strong) NSMutableArray*          ebArray;
@property (nonatomic,strong) NSString*                ebMoney; //总支出
@property (nonatomic,strong) NSString*                ebMeanMoney;//平均
@property (nonatomic,strong) EBBillModel*             billModel;

@end
