//
//  SMMarketModel.h
//  SheLong
//
//  Created by cara on 2019/1/28.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMMarketModel : NSObject

@property(nonatomic, assign)NSInteger type;
@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, assign)BOOL  isSelected;


@end

NS_ASSUME_NONNULL_END
