//
//  EBEventModel.h
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBEventModel : NSObject
@property (nonatomic,strong) NSString* eventName; //事项名
@property (nonatomic,strong) NSString* eventId;

-(void)initEmptyValue;
@end
