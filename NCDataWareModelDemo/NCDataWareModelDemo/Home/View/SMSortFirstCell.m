//
//  SMSortFirstCell.m
//  SheLong
//
//  Created by cara on 2019/1/29.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSortFirstCell.h"
#import "UIColor+Extend.h"
#import "UIImageView+WebCache.h"

@interface SMSortFirstCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sortImageView;
@property (weak, nonatomic) IBOutlet UILabel *sortLabel;

@end


@implementation SMSortFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor getColorWithHexString:@"0xCACACA"].CGColor;

}

-(void)setModel:(SMSortModel *)model{
    
    _model = model;
    [self.sortImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    self.sortLabel.text = model.name;
    
}


@end
