//
//  SMSortTwoTitleView.h
//  SheLong
//
//  Created by cara on 2019/1/30.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMSortModel.h"

typedef void(^SMSortTwoTitleViewBlock)(SMSortModel* _Nullable model);

NS_ASSUME_NONNULL_BEGIN

@interface SMSortTwoTitleView : UIView

@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, strong)SMSortModel* selectedModel;
@property(nonatomic, copy)SMSortTwoTitleViewBlock  sortTwoTitleViewBlock;

@end

NS_ASSUME_NONNULL_END
