//
//  EBMainViewController.h
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//  主界面

#import <UIKit/UIKit.h>

@interface EBMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)IBOutlet UITableView* ebTableView;
@property (nonatomic,strong)IBOutlet UIView* addView;

@property (nonatomic,strong) NSMutableArray *ebArray;

@property (nonatomic,strong) IBOutlet FlatPillButton* addNewBillButton;

-(IBAction)addNewBill:(id)sender;
-(IBAction)everyBill:(id)sender;
@end
