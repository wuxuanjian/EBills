//
//  EBCalculateViewController.m
//  EBills
//
//  Created by Woo on 13-4-27.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBCalculateViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "EBCalculateCell.h"
#import "EBDetailsDbService.h"
#import "EBBillDetailsModel.h"
#import "EBPeopleModel.h"
#import <math.h>

@interface EBCalculateViewController ()

@end

@implementation EBCalculateViewController
@synthesize ebArray,ebTabelView,ebMoney,ebMeanMoney,ebMoneyLabel,billModel,ebMeanMoneyLabel,titleView;

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
//    self.titleView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.titleView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
//    self.titleView.layer.shadowOpacity = 0.4;
//    self.titleView.layer.shadowRadius = 1.0;
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
    
    [self countDb];
    [self showView];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.ebTabelView setTableFooterView:view];
    // Do any additional setup after loading the view from its nib.
}

-(void) backPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) countDb
{
    ebArray = [EBDetailsDbService detailsNameDistinct:self.billModel.billDbName];
    CGFloat alwaysMoney = 0;
    for (int i = 0; i < [ebArray count]; i++)
    {
        EBPeopleModel* peopleModel = [ebArray objectAtIndex:i];
        NSArray * peopleDetailsArr = [EBDetailsDbService getPeopleDetailsModel:peopleModel.peopleName tableName:self.billModel.billDbName];
        CGFloat peopleAlwaysMoney = 0;
        for (int k = 0; k < [peopleDetailsArr count]; k++)
        {
            EBBillDetailsModel* detailsModel = [peopleDetailsArr objectAtIndex:k];
            peopleAlwaysMoney += [detailsModel.detailsMoney floatValue];
        }
        alwaysMoney += peopleAlwaysMoney;
        peopleModel.money =[NSString stringWithFormat:@"%.2f",peopleAlwaysMoney];
    }
    CGFloat meanMoney = alwaysMoney/[ebArray count];
    ebMoney = [NSString stringWithFormat:@"%.2f", alwaysMoney];
    ebMeanMoney = [NSString stringWithFormat:@"%.2f", meanMoney];
}

-(void) showView
{
    self.ebMoneyLabel.text = ebMoney;
    self.ebMeanMoneyLabel.text = ebMeanMoney;
}

#pragma UITableView Delegate
//每个Section 的 rows个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.ebArray && self.ebArray != nil)
    {
        return [self.ebArray count];
    }
    return 0;
}

//row 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"EBCalculateCell";
    EBCalculateCell *listCell = (EBCalculateCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!listCell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        listCell = [nib objectAtIndex:0];
    }
    EBPeopleModel* model = [self.ebArray objectAtIndex:[indexPath row]];
    listCell.name.text = model.peopleName;
    listCell.padMoney.text = model.money;
    CGFloat balanceMoney = [self.ebMeanMoney floatValue] - [model.money floatValue];
    if(balanceMoney < 0)
    {
        balanceMoney = [model.money floatValue] - [self.ebMeanMoney floatValue];
        listCell.balanceMoneyTitle.text = @"应收款：";
    }

    listCell.balanceMoney.text = [NSString stringWithFormat:@"%.2f",balanceMoney];
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return listCell;
}

//listview 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
