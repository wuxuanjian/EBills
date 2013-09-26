//
//  EBnewbillviewViewController.h
//  EBills
//
//  Created by umessage on 13-4-17.
//  Copyright (c) 2013年 umessage. All rights reserved.
//   添加新账目

#import <UIKit/UIKit.h>

@interface EBnewbillviewViewController : UIViewController
@property (nonatomic,strong) IBOutlet UITextField* name;
@property (nonatomic,strong) IBOutlet UITextField* date;
@property (nonatomic,strong) IBOutlet UITextField* people;
@property (nonatomic,strong) IBOutlet UITextField* plain;

-(IBAction)confirmBut:(id)sender;
@end
