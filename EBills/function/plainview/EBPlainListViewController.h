//
//  EBPlainListViewController.h
//  EBills
//
//  Created by Woo on 13-4-25.
//  Copyright (c) 2013年 umessage. All rights reserved.
//  账目详细

#import <UIKit/UIKit.h>
#import "EBBillModel.h"

@interface EBPlainListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)IBOutlet UITableView* ebTableView;
@property (nonatomic,strong)IBOutlet UIView* addView;

@property (nonatomic,strong) NSMutableArray *ebArray;
@property (nonatomic,strong) EBBillModel* billModel;

-(IBAction)addbillForm:(id)sender; //添加账单
-(IBAction)calculateBillForm:(id)sender;//计算账单

@end
