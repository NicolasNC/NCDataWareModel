//
//  SMAdProductModel.m
//  SheLong
//
//  Created by cara on 2019/1/24.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMAdProductModel.h"

@implementation SMAdProductModel


-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"productIdList"] && [value  isKindOfClass:[NSArray class]]){
        NSArray* jsonArr = value;
        if (jsonArr.count) {
            [self.productIdList removeAllObjects];
            [self.productIdList addObjectsFromArray:value];
        }
    }else if ([key isEqualToString:@"productList"] && [value  isKindOfClass:[NSArray class]]){
        NSArray* jsonArr = value;
        [self.productIdListModel removeAllObjects];
        for (NSDictionary* jsonDict in jsonArr) {
            SMDetailAdProductModel* model = [[SMDetailAdProductModel alloc]  init];
            [model setValuesForKeysWithDictionary:jsonDict];
            [self.productIdListModel addObject:model];
        }
    }else if ([key  isEqualToString:@"id"]){
        self.KID = [NSString  stringWithFormat:@"%@",value];
    }else{
        [super setValue:value forKey:key];
    }
}


-(NSMutableArray *)productIdList{
    if (!_productIdList) {
        _productIdList = [NSMutableArray array];
    }
    return _productIdList;
}

-(NSMutableArray<SMDetailAdProductModel *> *)productIdListModel{
    if (!_productIdListModel) {
        _productIdListModel = [NSMutableArray  array];
    }
    return _productIdListModel;
}


@end


@implementation SMDetailAdProductModel


-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.kID = [NSString stringWithFormat:@"%@",value];
    }else if ([key isEqualToString:@"attributeIdArr"] && [value  isKindOfClass:[NSArray class]]){
        NSArray* jsonArr = value;
        if (jsonArr.count) {
            [self.attributeIdArr removeAllObjects];
            [self.attributeIdArr addObjectsFromArray:value];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

-(NSMutableArray *)attributeIdArr{
    if (!_attributeIdArr) {
        _attributeIdArr = [NSMutableArray  array];
    }
    return _attributeIdArr;
}



@end
