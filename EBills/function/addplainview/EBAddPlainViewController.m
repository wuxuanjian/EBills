//
//  EBAddPlainViewController.m
//  EBills
//
//  Created by Woo on 13-4-25.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBAddPlainViewController.h"
#import "EBDetailsDbService.h"
#import "EBBillDetailsModel.h"
#import "EBPeopleDbService.h"
#import "EBPeopleModel.h"
#import "EBEventModel.h"

@interface EBAddPlainViewController ()

@end

@implementation EBAddPlainViewController 
@synthesize event;
@synthesize people;
@synthesize money;
@synthesize date;
@synthesize plain;
@synthesize billModel;
@synthesize fieldBgView;

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
//    self.title = @"添加账单";
    
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
    
    // Do any additional setup after loading the view from its nib.
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

#pragma mark 确定按钮
-(IBAction)confirmBut:(id)sender
{
    
    if([self.event.text isEqualToString:@""])
    {
        showCustomAlertMessage(@"请填账单发生时间！");
        return;
    }
    if([self.people.text isEqualToString:@""])
    {
        showCustomAlertMessage(@"请填写记垫款人！");
        return;
    }
    if([self.money.text isEqualToString:@""])
    {
        showCustomAlertMessage(@"请填写金额！");
        return;
    }
    if([self.date.text isEqualToString:@""])
    {
        
    }
    if([self.plain.text isEqualToString:@""])
    {
        
    }
    
    NSString *dateId = getDateId(); //日期id
    EBEventModel* eventModel = [EBPeopleDbService getEventModel:self.event.text]; //查 事件ID
    EBPeopleModel* peopleModel = [EBPeopleDbService getPeopleModel:self.people.text]; //查 人ID
    EBBillDetailsModel* model = [[EBBillDetailsModel alloc] init];
    model.detailsEvent = self.event.text;
    model.detailsPeople = self.people.text;
    model.detailsMoney = self.money.text;
//    model.detailsDate = self.date.text;
    model.detailsExPlain = self.plain.text;
    model.detailsId = dateId;
    
    if(![self.date.text isEqualToString:@""])
    {
        model.detailsDate = self.date.text;
    }
    else
    {
        model.detailsDate = getDateString();
    }
    
    if(peopleModel && peopleModel != nil)
    {
        model.detailsPeopleId = peopleModel.peopleId;
    }
    else
    {
        model.detailsPeopleId = dateId;
        peopleModel = [[EBPeopleModel alloc] init];
        peopleModel.peopleId = model.detailsPeopleId;
        peopleModel.peopleName = model.detailsPeople;
        [EBPeopleDbService insertPeople:peopleModel]; //写入 人 数据库
    }
    
    if(eventModel && eventModel != nil)
    {
        model.detailsEventId = eventModel.eventId;
    }
    else
    {
        model.detailsEventId = dateId;
        eventModel = [[EBEventModel alloc] init];
        eventModel.eventId = model.detailsEventId;
        eventModel.eventName = model.detailsEvent;
        [EBPeopleDbService insertEvent:eventModel]; //写入 事件 数据库
    }
    
    if(billModel && billModel.billId != nil && ![billModel.billId isEqualToString:@""])
    {
        [EBDetailsDbService insertDetails:model tableName:billModel.billDbName];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self cancelField];
    [self.event resignFirstResponder];
    [self.people resignFirstResponder];
    [self.money resignFirstResponder];
    [self.date resignFirstResponder];
    [self.plain resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //动画(Marks the beginning of a begin/commit animation block.)
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];  //动画曲线（开始和结束时慢）
    [UIView setAnimationDuration:0.25];    //持续时间
    if(textField == self.date || textField == self.plain)
    {
        self.fieldBgView.frame = CGRectMake(0, -85, self.fieldBgView.frame.size.width, self.fieldBgView.frame.size.height);
    }
    else
    {
        self.fieldBgView.frame = CGRectMake(0, 0, self.fieldBgView.frame.size.width, self.fieldBgView.frame.size.height);
    }
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self cancelField];
    //    [self.phone resignFirstResponder];
}

-(void) cancelField
{
    //动画(Marks the beginning of a begin/commit animation block.)
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];  //动画曲线（开始和结束时慢）
    [UIView setAnimationDuration:0.25];    //持续时间
    self.fieldBgView.frame = CGRectMake(0, 0, self.fieldBgView.frame.size.width, self.fieldBgView.frame.size.height);
    [UIView commitAnimations];
}

@end
