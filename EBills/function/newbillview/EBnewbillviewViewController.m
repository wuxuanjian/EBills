//
//  EBnewbillviewViewController.m
//  EBills
//
//  Created by umessage on 13-4-17.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBnewbillviewViewController.h"
#import "EBDetailsDbService.h"
#import "EBPeopleDbService.h"
#import "EBPeopleModel.h"
#import "EBBillModel.h"

@interface EBnewbillviewViewController ()

@end

@implementation EBnewbillviewViewController
@synthesize name;
@synthesize date;
@synthesize people;
@synthesize plain;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"新曾账本";
    
    UIButton* collectionBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [collectionBtn0 setBackgroundImage:[UIImage imageNamed:@"top_more"] forState:UIControlStateNormal];
    collectionBtn1.backgroundColor = [UIColor clearColor];
    collectionBtn1.frame = CGRectMake(0, 0, 49, 30);
    [collectionBtn1 addTarget:self action:@selector(backPage) forControlEvents:UIControlEventTouchUpInside];
    [collectionBtn1 setTitle:@"←" forState:UIControlStateNormal];
    [collectionBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    collectionBtn1.titleLabel.font = [UIFont systemFontOfSize: 35.0];
    UIBarButtonItem* rightBtn1 = [[UIBarButtonItem alloc] initWithCustomView:collectionBtn1];
    self.navigationItem.leftBarButtonItem = rightBtn1;
    
    
    [self.name limitTextLength:5];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.name resignFirstResponder];
    [self.people resignFirstResponder];
    [self.date resignFirstResponder];
    [self.plain resignFirstResponder];
}

-(IBAction)confirmBut:(id)sender
{
    
    if ([self.name.text isEqualToString:@""])
    {
        showCustomAlertMessage(@"请填写账本名称！");
        return;
    }
    if ([self.people.text isEqualToString:@""])
    {
        showCustomAlertMessage(@"请填写记账人性命！");
        return;
    }
    if ([self.date.text isEqualToString:@""])
    {
        
    }
    if ([self.plain.text isEqualToString:@""])
    {
        
    }
    NSString *dateId = getDateId(); //日期id
    NSString *billDBName = [NSString stringWithFormat:@"EB_DETAILS_FORM_%@",dateId];
    //跟具 人名返回model
    EBPeopleModel* peopleModel = [EBPeopleDbService getPeopleModel:self.people.text]; //查 人ID
    EBBillModel* billModel = [[EBBillModel alloc] init];
    billModel.billName = self.name.text;
    billModel.billId = dateId;
    billModel.billDate = getDateString(); //日期返回
    billModel.billPeople = self.people.text;
    billModel.billDetails = self.plain.text;
    billModel.billDbName = billDBName;
    if (![self.date.text isEqualToString:@""])
    {
        billModel.billDate = self.date.text;
    }
    
    if(peopleModel && peopleModel != nil)
    {
      billModel.billPeopleId = peopleModel.peopleId;
    }
    else
    {
        billModel.billPeopleId = dateId;
        peopleModel = [[EBPeopleModel alloc] init];
        peopleModel.peopleId = billModel.billPeopleId;
        peopleModel.peopleName = billModel.billPeople;
        [EBPeopleDbService insertPeople:peopleModel]; //写入 人 数据库
    }
    
    [EBPeopleDbService insertBill:billModel]; //插入账本名称
    
    [self.navigationController popViewControllerAnimated:YES];
    // 创建表
    [EBDetailsDbService createForm:billDBName]; //根据时间id创建 账本表
    
    @autoreleasepool {
        EBPeopleModel *ikl = [[EBPeopleModel alloc] init];
    }
}

@end
