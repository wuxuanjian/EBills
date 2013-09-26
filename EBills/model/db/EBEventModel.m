//
//  EBEventModel.m
//  EBills
//
//  Created by umessage on 13-4-16.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBEventModel.h"

@implementation EBEventModel
@synthesize eventId,eventName;

-(void)initEmptyValue
{
    if (!self.eventId)
    {
        self.eventId = @"";
    }
    if (!self.eventName)
    {
        self.eventName = @"";
    }
}

@end
