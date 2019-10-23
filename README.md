# NCDataWareModel
基于TMCache和AFNetworking的缓存请求类
 ![demo效果.gif](https://upload-images.jianshu.io/upload_images/2609892-7813b7949cffb9ce.gif?imageMogr2/auto-orient/strip)
 
####NCDataWareModel
封装的缓存类
通过请求url已经部分请求参数拼接做为key来存储数据
 ```
//获取key
- (NSString *)produceKey:(NSString *)requestFunc withOffset:(NSDictionary *)offset {
    return [[NSString stringWithFormat:@"%@%@", requestFunc, offset ? offset.description : @""] MD5];
}
//读取缓存
- (void)obtainData:(NSString *)requestFunc withOffset:(NSDictionary *)offset withBlock:(TMCacheObjectBlock)blo {
    
    [self objectForKey:[self produceKey:requestFunc withOffset:offset] block:blo];
}
//存储缓存
- (void)cacheData:(id<NSCoding>)data withRequestFunc:(NSString *)requestFunc withOffset:(NSDictionary *)offset {
   
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:data, @"data", [NSDate date], @"date",  nil];
    
    [self setObject:dic forKey:[self produceKey:requestFunc withOffset:offset] block:^(TMCache *cache, NSString *key, id object) {
  
    }];
}
```

####RequestModel
基于AFNetworking疯转的请求类
```
  NSString* url = @"supermarket/category/all/layer/products";
   NSDictionary *params = @{@"categoryId":self.selectedLeftModel.Kid,
          @"promotion":@"0",
          @"orderSort":@"0",
                             @"orderBy":@"0",
                             @"all":@"0"
        };
    [RequestModel requestFunc:url
                       params:params
              withRequestType:@"GET"
             withStartRequest:false
                withSaveCache:true withOffset:@{@"categoryId":self.selectedLeftModel.Kid}
    success:^(id  _Nonnull response) {
      //请求成功处理
    } failure:^(NSError * _Nonnull err) {
         //请求失败处理
    }];
```
- requstType  请求类型，”GET“ 或 ”POST“
- startRequest  为true时，不读缓存，直接请求服务器数据
    为false时,读缓存，如果没有缓存则会请求服务器数据
- saveCache 是否保存缓存，为true 则请求服务器数据后会保存数据
- offset 部分入参，主要用于区分同一个请求下不同数据，比如同一个url不同id请求的不同列表

####集成
下载[demo](https://github.com/NicolasNC/NCDataWareModel),将工程中的NCDataWareModel拖入到工程了，如果libs文件夹下相关的第三方已经导入，替换掉就可以了。
