//
//  EBAddPlainViewController.h
//  EBills
//
//  Created by Woo on 13-4-25.
//  Copyright (c) 2013年 umessage. All rights reserved.
//  新添加 账单

#import <UIKit/UIKit.h>
#import "EBBillModel.h"

@interface EBAddPlainViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITextField* event;
@property (nonatomic,strong) IBOutlet UITextField* people;
@property (nonatomic,strong) IBOutlet UITextField* money;
@property (nonatomic,strong) IBOutlet UITextField* date;
@property (nonatomic,strong) IBOutlet UITextField* plain;

@property (nonatomic,strong) EBBillModel* billModel;
@property (nonatomic,strong)IBOutlet UIView* fieldBgView;

-(IBAction)confirmBut:(id)sender;

@end
