//
//  SMSortLeftHeadView.h
//  SheLong
//
//  Created by cara on 2019/3/10.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMSortModel.h"

typedef void(^SMSortLeftHeadViewCallBlock)(SMSortModel* model);

NS_ASSUME_NONNULL_BEGIN

@interface SMSortLeftHeadView : UITableViewHeaderFooterView


@property(nonatomic, strong)SMSortModel* model;
@property(nonatomic, copy)SMSortLeftHeadViewCallBlock callBlock;

@end

NS_ASSUME_NONNULL_END
