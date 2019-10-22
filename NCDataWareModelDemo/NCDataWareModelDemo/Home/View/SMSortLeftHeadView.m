//
//  SMSortLeftHeadView.m
//  SheLong
//
//  Created by cara on 2019/3/10.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSortLeftHeadView.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Extend.h"

@interface SMSortLeftHeadView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end


@implementation SMSortLeftHeadView


-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer  alloc]  initWithTarget:self action:@selector(tapClicked)];
    [self addGestureRecognizer:tap];
}

-(void)tapClicked{
    if (self.callBlock) {
        self.callBlock(self.model);
    }
}

-(void)setModel:(SMSortModel *)model{
    _model = model;
    self.titleLabel.text = model.name;
    if (model.isSelected) {
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor  getColorWithHexString:@"0x010101"];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }else{
        self.titleLabel.backgroundColor = [UIColor  getColorWithHexString:@"0xf7f7f7"];
        self.titleLabel.textColor = [UIColor  getColorWithHexString:@"0x111111"];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
}

@end
