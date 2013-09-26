//
//  AlertShow.h
//  My12580_Hotel
//
//  Created by lichunhua on 11-11-10.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertShow : NSObject
void showCustomAlertMessage(NSString *message);
void showCustomTitleAlertMessage(NSString *title,NSString *message);
@end
