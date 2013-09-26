//
//  EBRequestBase.h
//  EBills
//
//  Created by Woo on 13-5-4.
//  Copyright (c) 2013年 umessage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

typedef void (^CommonStringResponseBlock)(NSString *responseString);
typedef void (^CommonErrorBlock)(NSError* error);
@interface EBRequestBase : MKNetworkEngine

+(EBRequestBase *) requestOperteBase;

-(MKNetworkOperation*) postRequestOperation:(NSString *) operationPath
                            paramDictionary:(NSMutableDictionary *)paramDic
                               onCompletion:(CommonStringResponseBlock) completion
                                    onError:(CommonErrorBlock) errorBlock
                                 onAnimated:(BOOL)animated;

@end
