//
//  LockSignalQueueModel.m
//  NCDataWareModelDemo
//
//  Created by nicolas on 2019/10/22.
//  Copyright © 2019 Nicolas. All rights reserved.
//

#import "LockSignalQueueModel.h"
dispatch_queue_t sDefaultSignalQueue = nil;

@implementation LockSignalQueueModel
+ (void)initialize {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        sDefaultSignalQueue = dispatch_queue_create("nicolas_default_safe_queue", DISPATCH_QUEUE_SERIAL);
    });
}
@end
