//
//  SMSortTwoTitleView.m
//  SheLong
//
//  Created by cara on 2019/1/30.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSortTwoTitleView.h"
#import "SMSortTwoTitleViewCell.h"

static NSString* resuSMSortTwoTitleViewCell = @"resuSMSortTwoTitleViewCell";


@interface SMSortTwoTitleView () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView* tableView;

@end

@implementation SMSortTwoTitleView


-(instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
    self.tableView.frame = self.bounds;
}

// MARK: - ==============UITableViewDelegate,UITableViewDataSource==============

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SMSortTwoTitleViewCell*  cell =  [tableView dequeueReusableCellWithIdentifier:resuSMSortTwoTitleViewCell forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedModel.isSelected = false;
    self.selectedModel = self.dataSource[indexPath.row];
    self.selectedModel.isSelected = true;
    [tableView reloadData];
    self.hidden = true;
    if (self.sortTwoTitleViewBlock) {
        self.sortTwoTitleViewBlock(self.selectedModel);
    }
}

// MARK: - ==============懒加载==============
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView  alloc]  initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib  nibWithNibName:@"SMSortTwoTitleViewCell" bundle:nil] forCellReuseIdentifier:resuSMSortTwoTitleViewCell];
    }
    return _tableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray  array];
    }
    return _dataSource;
}

@end
