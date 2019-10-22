//
//  SMMarketModel.m
//  SheLong
//
//  Created by cara on 2019/1/28.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMMarketModel.h"

@implementation SMMarketModel

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray  array];
    }
    return _dataSource;
}


@end
