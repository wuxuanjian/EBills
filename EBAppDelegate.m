//
//  EBAppDelegate.m
//  EBills
//
//  Created by umessage on 13-4-15.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBAppDelegate.h"
#import "EBMainViewController.h"
#import "EBDetailsDbManager.h"
#import "EBPeopleDbManager.h"

// 友盟统计KEY
#define UMENG_APPKEY @"51a3747956240b52590540e3"
#define UMCHANNELID @""

@implementation EBAppDelegate
@synthesize navigationDel;

# pragma --------------------  umeng area -------------------------------------
- (void)umengTrack {
    
    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //    [MobClick setAppVersion:@"2.0"]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) BATCH channelId:UMCHANNELID];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

# pragma --------------------  umeng area -------------------------------------


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initDatabase];
    [self umengTrack];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    EBMainViewController *viewController = [[EBMainViewController alloc] initWithNibName:@"EBMainViewController" bundle:nil];
    self.navigationDel = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.navigationDel.navigationBar.tintColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:247.0/255.0 alpha:1];
    //    [self.navigation pushViewController:viewController animated:YES];
    [self.window addSubview:self.navigationDel.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 数据库
-(void) initDatabase
{
    
    
    //---------------------begin------------------------
    BOOL dbExists = [EBDetailsDbManager dbExists];
    if (!dbExists)
    {
        [EBDetailsDbManager copyDB];
    }
    [EBDetailsDbManager openDatabase];
    
    dbExists = [EBPeopleDbManager dbExists];
    if (!dbExists)
    {
        [EBPeopleDbManager copyDB];
    }
    [EBPeopleDbManager openDatabase];
    
    //---------------------e n d -----------------------
    
}


@end
