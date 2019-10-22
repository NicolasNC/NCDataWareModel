//
//  SMSortTwoTitleViewCell.m
//  SheLong
//
//  Created by cara on 2019/1/30.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSortTwoTitleViewCell.h"


@interface SMSortTwoTitleViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;


@end

@implementation SMSortTwoTitleViewCell


-(void)setModel:(SMSortModel *)model{
    _model = model;
    self.titleLabel.text = model.name;
    self.titleImageView.hidden = !model.isSelected;
}


@end
