//
//  EBPlainListViewController.m
//  EBills
//
//  Created by Woo on 13-4-25.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBPlainListViewController.h"
#import "EBAddPlainViewController.h"
#import "EBCalculateViewController.h"
#import "EBDetailsDbService.h"
#import "EBBillDetailsModel.h"
#import "EBBillDetailsCell.h"

@interface EBPlainListViewController ()

@end

@implementation EBPlainListViewController
@synthesize ebTableView;
@synthesize ebArray;
@synthesize billModel;
@synthesize addView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.ebArray = [EBDetailsDbService detailsArray:billModel.billDbName];
    self.addView.frame = CGRectMake(0, -600, self.addView.frame.size.width, self.addView.frame.size.height);
    if([self.ebArray count] == 0)
    {
        self.addView.frame = CGRectMake(0, 0, self.addView.frame.size.width, self.addView.frame.size.height);
    }
    [self.ebTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton* collectionBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [collectionBtn0 setBackgroundImage:[UIImage imageNamed:@"top_more"] forState:UIControlStateNormal];
    collectionBtn0.backgroundColor = [UIColor clearColor];
    collectionBtn0.frame = CGRectMake(0, 0, 49, 30);
    [collectionBtn0 addTarget:self action:@selector(addBillButon) forControlEvents:UIControlEventTouchUpInside];
    [collectionBtn0 setTitle:@"···" forState:UIControlStateNormal];
    [collectionBtn0 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    collectionBtn0.titleLabel.font = [UIFont systemFontOfSize: 50.0];
    UIBarButtonItem* rightBtn0 = [[UIBarButtonItem alloc] initWithCustomView:collectionBtn0];
    self.navigationItem.rightBarButtonItem = rightBtn0;
    
    
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
    
    [self.view addSubview:self.addView];
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
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"EBBillDetailsCell";
    EBBillDetailsCell *listCell = (EBBillDetailsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!listCell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        listCell = [nib objectAtIndex:0];
    }
    EBBillDetailsModel* model = [self.ebArray objectAtIndex:[indexPath row]];
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [listCell showCell:model];
    return listCell;
    //    static NSString *senctionsTableIdentifier =  @"cellIdentifier";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:senctionsTableIdentifier];
    //    if (cell == nil)
    //    {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
    //                                      reuseIdentifier: senctionsTableIdentifier];
    //    }
    //    return cell;
    
}

//listview 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//添加账单按钮
-(void)addBillButon
{
    if (self.addView.frame.origin.y == -600)
    {
        [self viewAnimation:CGRectMake(0, 0, self.addView.frame.size.width, self.addView.frame.size.height)];
    }
    else
    {
        [self viewAnimation:CGRectMake(0, -600, self.addView.frame.size.width, self.addView.frame.size.height)];
    }
}

// view 动画
-(void)viewAnimation:(CGRect)rect
{
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.5];
    
    self.addView.frame = rect;
    
    [UIView commitAnimations];
}

-(IBAction)addbillForm:(id)sender //添加账单
{
    EBAddPlainViewController *page = [[EBAddPlainViewController alloc] initWithNibName:@"EBAddPlainViewController" bundle:nil];
    page.billModel = self.billModel;
    [self.navigationController pushViewController:page animated:YES];
}

-(IBAction)calculateBillForm:(id)sender//计算账单
{
    EBCalculateViewController *page = [[EBCalculateViewController alloc] initWithNibName:@"EBCalculateViewController" bundle:nil];
    page.billModel = self.billModel;
    [self.navigationController pushViewController:page animated:YES];
}


@end
