//
//  SMBaseModel.h
//  SheLong
//
//  Created by cara on 2019/1/24.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMBaseModel : NSObject


/**
 *  商品判断有无情况，0表示已售罄，1表示有商品，2表示已下架
 *
 */
-(NSInteger)isWhatGOODStatus:(NSString*)status  stockStatus:(NSString*)stockStatus;


@end

NS_ASSUME_NONNULL_END
