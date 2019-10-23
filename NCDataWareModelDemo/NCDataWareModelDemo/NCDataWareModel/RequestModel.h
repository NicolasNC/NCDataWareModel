//
//  RequestModel.h
//  NCDataWareModelDemo
//
//  Created by nicolas on 2019/10/22.
//  Copyright © 2019 Nicolas. All rights reserved.
//

#import "NCModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestModel : NCModel
/*
 url : Request url
 params : Request params
 requstType : Request Type  "POST" or "GET"
 startRequest : if startRequest is true do not read cache
 saveCache :  saveCache --save cache
 offset :  cache key
 */
+ (void)requestFunc:(NSString *)url
          params:(NSDictionary *)params
 withRequestType:(NSString *)requstType
withStartRequest:(bool)startRequest
   withSaveCache:(bool)saveCache
      withOffset:(NSDictionary *)offset
         success:(void (^)(id response))success
            failure:(void (^)(NSError *err))failure;
@end

NS_ASSUME_NONNULL_END
