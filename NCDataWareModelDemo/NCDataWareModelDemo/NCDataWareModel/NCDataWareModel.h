//
//  NCDataWareModel.h
//  NCDataWareModelDemo
//
//  Created by nicolas on 2019/10/22.
//  Copyright © 2019 Nicolas. All rights reserved.
//

#import "TMCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface NCDataWareModel : TMCache
- (void)cacheData:(id<NSCoding>)data withRequestFunc:(NSString *)requestFunc withOffset:(NSDictionary *)offset;
- (void)obtainData:(NSString *)requestFunc withOffset:(NSDictionary *)offset withBlock:(TMCacheObjectBlock)blo;
- (id<NSCoding>)obtainData:(NSString *)requestFunc withOffset:(NSDictionary *)offset;

- (id)decodeObtainData:(NSDictionary *)dic;

- (void)deleteCacheData:(NSString *)requestFunc withOffset:(NSDictionary *)offset;

- (NSString *)produceKey:(NSString *)requestFunc withOffset:(NSDictionary *)offset;
@end

NS_ASSUME_NONNULL_END
