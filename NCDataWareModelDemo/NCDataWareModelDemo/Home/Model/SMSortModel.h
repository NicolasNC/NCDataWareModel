//
//  SMSortModel.h
//  SheLong
//
//  Created by cara on 2019/1/29.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
 /*
 "id": 103,
 "name": "测试1级分类",
 "parentId": 0,
 "iconUrl": "https://files-test.shelongwang.com:3333/upload/supermarket/2018/12/1146d64b-0b57-4d1b-a1f3-8987d9f07b8f.png",
 "adImage": "",
 "adLink": "123",
 "sort": 14,
 "subCategories"
 */

@class SMSortModel;

@interface SMSortModel : SMBaseModel

@property(nonatomic, copy)NSString* Kid;
@property(nonatomic, copy)NSString* name;
@property(nonatomic, copy)NSString* parentId;
@property(nonatomic, copy)NSString* iconUrl;
@property(nonatomic, copy)NSString* adImage;
@property(nonatomic, copy)NSString* adLink;
@property(nonatomic, copy)NSString* sort;
@property(nonatomic, strong)NSMutableArray<SMSortModel*>* subCategories;
@property(nonatomic, strong)NSMutableArray* twoSortDataSource;
@property(nonatomic, assign)BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
