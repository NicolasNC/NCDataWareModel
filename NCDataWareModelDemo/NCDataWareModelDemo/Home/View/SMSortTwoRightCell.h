//
//  SMSortTwoRightCell.h
//  SheLong
//
//  Created by cara on 2019/1/29.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMAdProductModel.h"

typedef void(^SMSortTwoRightCellCallBlock)(SMDetailAdProductModel* _Nonnull model,NSInteger type);

NS_ASSUME_NONNULL_BEGIN

@interface SMSortTwoRightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sortImageView;
@property(nonatomic, strong)SMDetailAdProductModel* model;
@property(nonatomic, copy)SMSortTwoRightCellCallBlock callBlock;

@end

NS_ASSUME_NONNULL_END
