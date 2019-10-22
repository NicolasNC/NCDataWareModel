//
//  SMSortTwoRightCell.m
//  SheLong
//
//  Created by cara on 2019/1/29.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSortTwoRightCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Extend.h"

@interface SMSortTwoRightCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallLabel1;
@property (weak, nonatomic) IBOutlet UILabel *smallLabel2;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *tatolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *noImageView;
@property (weak, nonatomic) IBOutlet UIView *fenGeView;



@end

@implementation SMSortTwoRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.smallLabel1.clipsToBounds = self.smallLabel2.clipsToBounds = true;
    self.smallLabel1.layer.cornerRadius = self.smallLabel2.layer.cornerRadius = 8.0f;
    self.smallLabel1.backgroundColor = self.smallLabel2.backgroundColor = [UIColor getColorWithHexString:@"0xE7F9E6"];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer  alloc]  initWithTarget:self action:@selector(tapClicked)];
    [self addGestureRecognizer:tap];
    
}

-(void)tapClicked{
    if (self.callBlock) {
        self.callBlock(self.model,1);
    }
}


-(void)setModel:(SMDetailAdProductModel *)model{
    _model = model;
    [self.sortImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.nameLabel.text = model.productTitle;
    self.detailLabel.text = model.subTitle;
    NSString* f = [NSString stringWithFormat:@"￥%.2f ",[model.discountPrice floatValue]];
    NSString* price = [NSString stringWithFormat:@"%@/%@",f,model.unit];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]      initWithString:price];
    NSDictionary* dictionary1 = @{NSForegroundColorAttributeName:[UIColor getColorWithHexString:@"0x00AC00"]};
    NSDictionary* dictionary2 = @{NSForegroundColorAttributeName:[UIColor getColorWithHexString:@"0x8A8A8A"]};
    [attrStr addAttributes:dictionary1 range:NSMakeRange(0, f.length)];
    [attrStr addAttributes:dictionary2 range:NSMakeRange(f.length+1, model.unit.length)];
    self.priceLabel.attributedText = attrStr;
    NSString* lab1 = [self labelText:model.attributeIdArr.firstObject] ;
    if (lab1.length) {
        self.smallLabel1.text = lab1;
    }
    if (model.attributeIdArr.count >= 2) {
        NSString* lab2 = [self labelText:model.attributeIdArr[1]] ;
        if (lab2.length) {
            self.smallLabel2.text = lab2;
        }
    }
    if([model.discountPrice isEqualToString:model.price]){
        self.tatolLabel.hidden = true;
        self.fenGeView.hidden = true;
    }else{
        self.fenGeView.hidden = false;
        self.tatolLabel.hidden = false;
        self.tatolLabel.text = [NSString stringWithFormat:@"￥%.2f ",[model.price floatValue]];
    }
    NSInteger status = [model  isWhatGOODStatus:model.status stockStatus:model.stockStatus];
    self.noImageView.hidden = false;
    self.sortImageView.alpha = 0.5;
    if(status == 0){//没有了
        self.addBtn.selected = true;
        self.addBtn.userInteractionEnabled = false;
        self.noImageView.image = [UIImage  imageNamed:@"suYipa"];
    }else if (status == 1){//有货
        self.sortImageView.alpha = 1.0;
        self.addBtn.selected = false;
        self.addBtn.userInteractionEnabled = true;
        self.noImageView.hidden = true;
    }else{//下架了
        self.addBtn.selected = true;
        self.addBtn.userInteractionEnabled = false;
        self.noImageView.image = [UIImage  imageNamed:@"suXiaJia"];
    }
}
-(NSString*)labelText:(NSNumber*)num{
    NSString* str = @"";
    switch (num.intValue) {
        case 1:
            str = @" 推荐 ";
            break;
        case 2:
            str = @" 热门 ";
            break;
        case 3:
            str = @" 新品 ";
            break;
        case 4:
            str = @" 特价 ";
            break;
        case 5:
            str = @" 满减包邮 ";
            break;
        default:
            break;
    }
    return str;
}

- (IBAction)addbtnClicked:(UIButton *)sender {
    if (self.callBlock) {
        self.callBlock(self.model,2);
    }
}






@end
