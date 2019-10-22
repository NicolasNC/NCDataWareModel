//
//  SMSortRightHeadView.m
//  SheLong
//
//  Created by cara on 2019/3/10.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSortRightHeadView.h"


@interface SMSortRightHeadView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end


@implementation SMSortRightHeadView


-(void)setModel:(SMSortModel *)model{
    _model = model;
    self.titleLabel.text = model.name;
}


@end
