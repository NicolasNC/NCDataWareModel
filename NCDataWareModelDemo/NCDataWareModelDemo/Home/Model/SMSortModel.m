//
//  SMSortModel.m
//  SheLong
//
//  Created by cara on 2019/1/29.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSortModel.h"
#import "SMAdProductModel.h"

@implementation SMSortModel


-(instancetype)init{
    self = [super init];
    
    if (self) {
        self.isSelected = false;
    }
    
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key  isEqualToString:@"id"]) {
        self.Kid = [NSString  stringWithFormat:@"%@",value];
    }else if ([key  isEqualToString:@"subCategories"]){
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray* jsonArr = value;
            [self.subCategories removeAllObjects];
            for (NSDictionary* jsonDict in jsonArr) {
                SMSortModel* model =  [[SMSortModel alloc]  init];
                [model setValuesForKeysWithDictionary:jsonDict];
                [self.subCategories addObject:model];
            }
        }
    }else if ([key  isEqualToString:@"products"]){
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray* jsonArr = value;
            [self.twoSortDataSource removeAllObjects];
            for (NSDictionary* jsonDict in jsonArr) {
                SMDetailAdProductModel* model =  [[SMDetailAdProductModel alloc]  init];
                [model setValuesForKeysWithDictionary:jsonDict];
                [self.twoSortDataSource addObject:model];
            }
        }
    }else{
        [super setValue:value forKey:key];
    }
}

-(NSMutableArray<SMSortModel *> *)subCategories{
    if (!_subCategories) {
        _subCategories = [NSMutableArray  array];
    }
    return _subCategories;
}
-(NSMutableArray *)twoSortDataSource{
    if (!_twoSortDataSource) {
        _twoSortDataSource = [NSMutableArray array];
    }
    return _twoSortDataSource;
}



@end
