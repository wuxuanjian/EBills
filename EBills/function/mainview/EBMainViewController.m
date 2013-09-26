//
//  EBMainViewController.m
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBMainViewController.h"
#import "EBnewbillviewViewController.h"
#import "EBPlainListViewController.h"
#import "EBBillsMenuCell.h"
#import "EBPeopleDbService.h"

@interface EBMainViewController ()

@end

@implementation EBMainViewController
@synthesize ebTableView;
@synthesize addView;
@synthesize ebArray;
@synthesize addNewBillButton;

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
    self.ebArray = [EBPeopleDbService billArray];
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
//    self.title = @"最近账目";
    UIButton* collectionBtn0 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [collectionBtn0 setBackgroundImage:[UIImage imageNamed:@"top_more"] forState:UIControlStateNormal];
    collectionBtn0.backgroundColor = [UIColor clearColor];
    collectionBtn0.frame = CGRectMake(0, 0, 49, 30);
    [collectionBtn0 addTarget:self action:@selector(completeButton) forControlEvents:UIControlEventTouchUpInside];
    [collectionBtn0 setTitle:@"···" forState:UIControlStateNormal];
    [collectionBtn0 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    collectionBtn0.titleLabel.font = [UIFont systemFontOfSize: 50.0];
    UIBarButtonItem* rightBtn0 = [[UIBarButtonItem alloc] initWithCustomView:collectionBtn0];
    self.navigationItem.rightBarButtonItem = rightBtn0;
    
    [self.view addSubview:self.addView];
    
    self.ebTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, 320, [UIScreen mainScreen].applicationFrame.size.height - 45) ];
    self.ebTableView.delegate = self;
    self.ebTableView.dataSource = self;
    self.ebTableView.backgroundColor = [UIColor blueColor];
    self.ebTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.ebTableView];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.ebTableView setTableFooterView:view];
    [self setViewColor];
    [self.ebTableView reloadData];
//    self.ebArray = [[NSMutableArray alloc] initWithCapacity:3];
    
//    self.addNewBillButton.faceColor = [UIColor colorWithRed:243.0/255.0 green:152.0/255.0 blue:0 alpha:1.0];
//    self.addNewBillButton.sideColor = [UIColor colorWithRed:170.0/255.0 green:105.0/255.0 blue:0 alpha:1.0];
//    self.addNewBillButton.radius = 6.0;
//    self.addNewBillButton.margin = 7.0;
//    self.addNewBillButton.depth = 6.0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置颜色
-(void) setViewColor
{
    self.view.backgroundColor = DEFINE_MAINVIEW_BG_COLOR;
}

#pragma UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

//每个Section 的 rows个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.ebArray && self.ebArray != nil)
    {
        return [self.ebArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}

//row 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"EBBillsMenuCell";
    EBBillsMenuCell *listCell = (EBBillsMenuCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!listCell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
        listCell = [nib objectAtIndex:0];
    }
    EBBillModel* model = [self.ebArray objectAtIndex:[indexPath row]];
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [listCell shoeCell:model];
    return listCell;
}

//listview 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EBPlainListViewController *page = [[EBPlainListViewController alloc] initWithNibName:@"EBPlainListViewController" bundle:nil];
    EBBillModel* model = [self.ebArray objectAtIndex:[indexPath row]];
    page.billModel = model;
    [self.navigationController pushViewController:page animated:YES];
}


//----------------------------------------------------------------------------------------
-(void)completeButton
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

#pragma mark 添加按钮
-(IBAction)addNewBill:(id)sender
{
    EBnewbillviewViewController *page = [[EBnewbillviewViewController alloc] initWithNibName:@"EBnewbillviewViewController" bundle:nil];
    [self.navigationController pushViewController:page animated:YES];
}

-(IBAction)everyBill:(id)sender
{
    
}

// view 动画
-(void)viewAnimation:(CGRect)rect
{
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.5];
    
    self.addView.frame = rect;
    
    [UIView commitAnimations];
}

@end
