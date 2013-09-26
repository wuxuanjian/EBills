//
//  EBRequestBase.m
//  EBills
//
//  Created by Woo on 13-5-4.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import "EBRequestBase.h"

static EBRequestBase *operateRequest = nil;

@implementation EBRequestBase

//http://127.0.0.1:8080/UserPort?wsdl

+(EBRequestBase *) requestOperteBase
{
    if( !operateRequest )
    {
        operateRequest = [[EBRequestBase alloc] initWithDefaultSettings];
    }
    return operateRequest;
}

-(id) initWithDefaultSettings {
    
    if(self = [super initWithHostName:@"testbed2.mknetworkkit.com" customHeaderFields:@{@"x-client-identifier" : @"iOS"}]) {
        
    }
    
    return self;
}

-(MKNetworkOperation*) postRequestOperation:(NSString *) operationPath
                            paramDictionary:(NSMutableDictionary *)paramDic
                               onCompletion:(CommonStringResponseBlock) completion
                                    onError:(CommonErrorBlock) errorBlock
                                 onAnimated:(BOOL)animated{
    if(![self isReachable])
    {
        showCustomAlertMessage(@"您的网络有点问题，请检查网络!");
        return nil;
    }
    MKNetworkOperation * op = [self operationWithPath:operationPath
                                               params:paramDic
                                           httpMethod:@"POST"];

    
    [op addCompletionHandler:^(MKNetworkOperation* completedOperation)
     {
         DLog(@"%@", completedOperation.responseString);
         completion(completedOperation.responseString);
         
     }
    errorHandler:^(MKNetworkOperation* completedOperation, NSError* error)
     {

         errorBlock(error);

         DLog(@"%@", [error localizedDescription]);
     }];
    
    [self enqueueOperation:op];
    return op;
}

@end
