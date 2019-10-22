//
//  SMBaseModel.m
//  SheLong
//
//  Created by cara on 2019/1/24.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMBaseModel.h"

@implementation SMBaseModel

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else if ([value isKindOfClass:[NSNull class]]){
        [self setValue:[NSString stringWithFormat:@"%@",@""] forKey:key];
    }else if ([value isKindOfClass:[NSString class]] && !value){
        [self setValue:[NSString stringWithFormat:@"%@",@""] forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //NSLog(@"还没有定义%@",key);
}

/**
 *  商品判断有无情况，0表示已售罄，1表示有商品，2表示已下架
 *
 */
-(NSInteger)isWhatGOODStatus:(NSString*)status  stockStatus:(NSString*)stockStatus{
    NSInteger targetStaus = 0;
    if (status.integerValue == 0){
        targetStaus = 2;
    }
    if (status.integerValue ==1 && stockStatus.integerValue == 1){
        targetStaus = 1;
    }
    if (status.integerValue == 1&& stockStatus.integerValue == 0){
        targetStaus = 0;
    }
    return targetStaus;
}

@end
