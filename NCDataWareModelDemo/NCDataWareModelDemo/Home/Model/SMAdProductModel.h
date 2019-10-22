//
//  SMAdProductModel.h
//  SheLong
//
//  Created by cara on 2019/1/24.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class SMDetailAdProductModel;

@interface SMAdProductModel : SMBaseModel

@property(nonatomic, copy)NSString* storeCode;
@property(nonatomic, strong)NSMutableArray* productIdList;
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* sort;
@property(nonatomic, copy)NSString* image;
@property(nonatomic, copy)NSString* link;
@property(nonatomic, copy)NSString* productId;
@property(nonatomic, copy)NSString* KID;
@property(nonatomic, copy)NSString* categoryId;
@property(nonatomic, copy)NSString* ShareContent;
@property(nonatomic, strong)NSMutableArray<SMDetailAdProductModel*>* productIdListModel;

@end


@interface SMDetailAdProductModel : SMBaseModel

@property(nonatomic, copy)NSString* kID;
@property(nonatomic, copy)NSString* productTitle;
@property(nonatomic, copy)NSString* specificationId;
@property(nonatomic, copy)NSString* specificationName;
@property(nonatomic, copy)NSString* subTitle;
@property(nonatomic, copy)NSString* discountPrice;
@property(nonatomic, copy)NSString* status;
@property(nonatomic, copy)NSString* stockStatus;
@property(nonatomic, copy)NSString* unit;
@property(nonatomic, copy)NSString* price;
@property(nonatomic, copy)NSString* buyNum;
@property(nonatomic, copy)NSString* image;
@property(nonatomic, strong)NSMutableArray* attributeIdArr;
///用来标明是更多
@property(nonatomic, assign)NSInteger type;




@end

NS_ASSUME_NONNULL_END
