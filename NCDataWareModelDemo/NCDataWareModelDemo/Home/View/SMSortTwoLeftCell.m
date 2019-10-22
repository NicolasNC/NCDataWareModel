//
//  SMSortTwoLeftCell.m
//  SheLong
//
//  Created by cara on 2019/1/29.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSortTwoLeftCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Extend.h"


@interface SMSortTwoLeftCell()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SMSortTwoLeftCell

-(void)setModel:(SMSortModel *)model{
    _model = model;
    self.nameLabel.text = model.name;
    if (model.isSelected) {
        self.nameLabel.textColor = [UIColor  getColorWithHexString:@"0x006E93"];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:14];
        self.selectedView.hidden = false;
    }else{
        self.nameLabel.textColor = [UIColor  getColorWithHexString:@"0x9E9D9D"];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.selectedView.hidden = true;
    }
}



@end
