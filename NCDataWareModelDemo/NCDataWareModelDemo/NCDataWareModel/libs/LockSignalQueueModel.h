//
//  LockSignalQueueModel.h
//  NCDataWareModelDemo
//
//  Created by nicolas on 2019/10/22.
//  Copyright © 2019 Nicolas. All rights reserved.
//

#import "NCModel.h"

NS_ASSUME_NONNULL_BEGIN
extern dispatch_queue_t sDefaultSignalQueue;

#define LOCK_SIGNAL(...) \
dispatch_async(sDefaultSignalQueue, ^{ \
NSLog(@"current====%@", [NSThread currentThread]);\
__VA_ARGS__; \
});

@interface LockSignalQueueModel : NCModel

@end

NS_ASSUME_NONNULL_END
