//
//  RequestModel.m
//  NCDataWareModelDemo
//
//  Created by nicolas on 2019/10/22.
//  Copyright © 2019 Nicolas. All rights reserved.
//

#import "RequestModel.h"
#import "AFNetworking.h"
#import "NCDataWareModel.h"

@implementation RequestModel
+ (NSString *)obtainSplice:(NSDictionary *)dic{
    NSArray *keys = [dic allKeys];
    NSMutableArray *paramArr = @[].mutableCopy;
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        NSString *value = [dic valueForKey:key];
        if (value && value.length != 0) {
            [paramArr addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
        }
    }
    NSString *str = [paramArr componentsJoinedByString:@"&"];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [@"?" stringByAppendingString:str];
}

+ (void)requestFunc:(NSString *)url
             params:(NSDictionary *)params
    withRequestType:(NSString *)requstType
   withStartRequest:(bool)startRequest
      withSaveCache:(bool)saveCache
         withOffset:(NSDictionary *)offset
        cacheSuccess:(void (^)(id response))cacheSuccess
            success:(void (^)(id response))success
            failure:(void (^)(NSError *err))failure{
    if([requstType isEqualToString:@"GET"]) {
      url = [url stringByAppendingString:[RequestModel obtainSplice:params]];
    }
    if(!startRequest) {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NCDataWareModel *dwm = [NCDataWareModel sharedCache];
            [dwm obtainData:url withOffset:offset withBlock:^(TMCache *cache, NSString *key, id object) {
                if(object) {
                    NSDictionary *diccc = [[NCDataWareModel sharedCache] decodeObtainData:object];
                    cacheSuccess(diccc);
                    return;
                }
            }];
        });
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/vnd.apple.mpegurl", nil];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    if([requstType isEqualToString:@"GET"]) {
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(result);
                NSLog(@"=result==%@",result);
                if ([result[@"status"] integerValue] == 1 && saveCache) {
                    [[NCDataWareModel sharedCache]cacheData:result withRequestFunc:url withOffset:offset];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }else{
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(result);
                NSLog(@"=result==%@",result);
                if ([result[@"status"] integerValue] == 1 && saveCache) {
                    [[NCDataWareModel sharedCache]cacheData:result withRequestFunc:url withOffset:offset];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}
@end
