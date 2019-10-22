//
//  NCDataWareModel.m
//  NCDataWareModelDemo
//
//  Created by nicolas on 2019/10/22.
//  Copyright © 2019 Nicolas. All rights reserved.
//

#import "NCDataWareModel.h"
#import "NSString+MD5.h"

@implementation NCDataWareModel
- (void)dealloc {
    
}

- (id)init {
    
    self = [super init];
    
    if(self) {
        
    }
    return self;
}

- (NSString *)produceKey:(NSString *)requestFunc withOffset:(NSDictionary *)offset {
    
    return [[NSString stringWithFormat:@"%@%@", requestFunc, offset ? offset.description : @""] MD5];
}
//<NSCoding>
- (id)decodeObtainData:(NSDictionary *)dic {
    
    return dic[@"data"];
}

- (void)obtainData:(NSString *)requestFunc withOffset:(NSDictionary *)offset withBlock:(TMCacheObjectBlock)blo {
    
    [self objectForKey:[self produceKey:requestFunc withOffset:offset] block:blo];
}

- (void)deleteCacheData:(NSString *)requestFunc withOffset:(NSDictionary *)offset {
    
    [self removeObjectForKey:[self produceKey:requestFunc withOffset:offset]];
}

- (id<NSCoding>)obtainData:(NSString *)requestFunc withOffset:(NSDictionary *)offset {
    
    NSDictionary *dic = [self objectForKey:[self produceKey:requestFunc withOffset:offset]];
    
    return [self decodeObtainData:dic];
}

- (void)cacheData:(id<NSCoding>)data withRequestFunc:(NSString *)requestFunc withOffset:(NSDictionary *)offset {
   
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:data, @"data", [NSDate date], @"date",  nil];
    
    [self setObject:dic forKey:[self produceKey:requestFunc withOffset:offset] block:^(TMCache *cache, NSString *key, id object) {
        
    }];
}
@end
