//
//  SMSecondSortController.m
//  SheLong
//
//  Created by cara on 2019/1/29.
//  Copyright © 2019年 nicolas. All rights reserved.
//

#import "SMSecondSortController.h"
#import "SMSortTwoLeftCell.h"
#import "SMSortTwoRightCell.h"
#import "SMAdProductModel.h"
#import "SMNavTitleView.h"
#import "SMSortLeftHeadView.h"
#import "SMSortRightHeadView.h"
#import "RequestModel.h"
#import "UIImageView+WebCache.h"
#import "UIColor+Extend.h"

static NSString* resuSMSortLeftHeadView = @"resuSMSortLeftHeadView";
static NSString* resuSMSortRightHeadView = @"resuSMSortRightHeadView";
static NSString* resuSMSortTwoLeftCell = @"resuSMSortTwoLeftCell";
static NSString* resuSMSortTwoRightCell = @"resuSMSortTwoRightCell";

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kNavBarHeight (ScreenHeight >= 812.0 ? 88 : 64)
#define SafeAreaBottomHeight (ScreenHeight >= 812.0 ? 34 : 0)

@interface SMSecondSortController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView* leftTableView;
@property(nonatomic, strong)NSMutableArray* leftDataSource;
@property(nonatomic, strong)SMSortModel* selectedLeftModel;
@property(nonatomic, strong)SMSortModel* selectedLeftSecondModel;
@property(nonatomic, strong)UITableView* rightTableView;
@property(nonatomic, strong)NSMutableArray* rightDataSource;
@property(nonatomic, strong)SMNavTitleView* navTitleView;
@property(nonatomic, strong)UILabel* titleLabel;
@property(nonatomic, strong)UIImageView* titleImageView;
@property(nonatomic, strong)NSMutableArray* sortDataSource;
@property(nonatomic, strong)UIImageView* headImageView;
@property(nonatomic, assign)CGFloat  imgHeight;

@end

@implementation SMSecondSortController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self  setupUI];
    [self loadData];
}


-(void)setupUI{
    self.imgHeight = (ScreenWidth-115)*89/261+30;
   
    self.automaticallyAdjustsScrollViewInsets = false;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.leftTableView];
    self.leftTableView.frame = CGRectMake(0, kNavBarHeight, 95, ScreenHeight-kNavBarHeight-SafeAreaBottomHeight);
    [self.view addSubview:self.rightTableView];
    self.rightTableView.frame = CGRectMake(95, kNavBarHeight, ScreenWidth-95, ScreenHeight-kNavBarHeight-SafeAreaBottomHeight);
    
}

-(void)loadData{
    self.headImageView.hidden = true;
    self.rightTableView.frame = CGRectMake(95, kNavBarHeight, ScreenWidth-95, ScreenHeight-kNavBarHeight-SafeAreaBottomHeight);    
    NSString *leftUrl = @"https://api.shelongwang.com:1111/supermarket/category/all/layer";
    [RequestModel requestFunc:leftUrl
                       params:@{@"categoryId":@"9",
                                @"all":@"1"
                       } withRequestType:@"GET" withStartRequest:false withSaveCache:true withOffset:@{@"categoryId":@"9",
                                                                                                      @"all":@"1"
                       } cacheSuccess:^(id  _Nonnull response) {
        NSLog(@"=====");
    } success:^(id  _Nonnull response) {
        if(response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]){
                   NSArray* jsonArr = response[@"data"];
                   for (NSDictionary* jsonDict in jsonArr) {
                       SMSortModel* model = [[SMSortModel alloc]  init];
                       [model setValuesForKeysWithDictionary:jsonDict];
                       NSInteger  index = [jsonArr  indexOfObject:jsonDict];
                       if (index) {
                           model.isSelected = false;
                       }else{
                           model.isSelected = true;
                           self.selectedLeftModel  = model;
                       }
                       [self.leftDataSource addObject:model];
                   }
               }
               if (self.leftDataSource.count) {
                   [self loadRightData];
               }else{
                   [self.rightTableView reloadData];
               }
               [self.leftTableView reloadData];
    } failure:^(NSError * _Nonnull err) {
       NSLog(@"error = %@",err);
    }];
}
-(void)reloadVCData{
    [self loadData];
}
-(void)loadRightData{
    [self.rightDataSource removeAllObjects];
    [self.rightTableView reloadData];
    NSString* url = @"https://api.shelongwang.com:1111/supermarket/category/all/layer/products";
    NSDictionary *params = @{@"categoryId":self.selectedLeftModel.Kid,
          @"promotion":@"0",
          @"orderSort":@"0",
                             @"orderBy":@"0",
                             @"all":@"0"
        };
    if (self.selectedLeftModel == self.leftDataSource.firstObject) {
        params = @{@"categoryId":self.selectedLeftModel.Kid,
          @"promotion":@"0",
          @"orderSort":@"0",
                             @"orderBy":@"0",
                             @"all":@"1"
        };
    }
    [RequestModel requestFunc:url params:params withRequestType:@"GET" withStartRequest:true withSaveCache:true withOffset:@{@"categoryId":self.selectedLeftModel.Kid} cacheSuccess:^(id  _Nonnull response) {
        
    } success:^(id  _Nonnull response) {
       if(response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]){
            NSArray* data = response[@"data"];
            if (self.selectedLeftModel == self.leftDataSource.firstObject) {//全部
                id  tmp = data.firstObject;
                if(tmp[@"products"] && [tmp[@"products"] isKindOfClass:[NSArray class]]){
                    NSArray* jsonArr = tmp[@"products"];
                    for (NSDictionary* jsonDict in jsonArr) {
                        SMDetailAdProductModel* model = [[SMDetailAdProductModel alloc]  init];
                        [model setValuesForKeysWithDictionary:jsonDict];
                        [self.rightDataSource addObject:model];
                    }
                }
                
            }else{//二级
                if(response[@"data"] && [response[@"data"] isKindOfClass:[NSArray class]]){
                    NSArray* jsonArr = response[@"data"];
                    for (NSDictionary* jsonDict in jsonArr) {
                        SMSortModel* model = [[SMSortModel alloc]  init];
                        [model setValuesForKeysWithDictionary:jsonDict];
                        [self.rightDataSource addObject:model];
                    }
                }
                BOOL  isFlag = false;
                for (SMSortModel* model in self.rightDataSource ) {
                    if (model.twoSortDataSource.count) {
                        isFlag = true;
                        break;
                    }
                }
            }
        }
        [self.rightTableView reloadData];
    } failure:^(NSError * _Nonnull err) {
        NSLog(@" error = %@",err);
    }];
   
}
// MARK: - ==============UITableViewDelegate,UITableViewDataSource==============

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return self.leftDataSource.count;
    }else{
        if(self.selectedLeftModel == self.leftDataSource.firstObject){
            return 1;
        }else{
            return self.rightDataSource.count;
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        SMSortModel* model = self.leftDataSource[section];
        return  model.isSelected ?  model.subCategories.count : 0;
    }else{
        if(self.selectedLeftModel == self.leftDataSource.firstObject){
            return self.rightDataSource.count;
        }else{
            SMSortModel* model = self.rightDataSource[section];
            return  model.twoSortDataSource ?  model.twoSortDataSource.count : 0;
        }
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        SMSortLeftHeadView* headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:resuSMSortLeftHeadView];
        headView.model = self.leftDataSource[section];
        __weak typeof(self) sl = self;
        headView.callBlock = ^(SMSortModel *model) {
            sl.selectedLeftModel.isSelected = false;
            sl.selectedLeftModel = sl.leftDataSource[section];
            sl.selectedLeftModel.isSelected = true;
            sl.selectedLeftSecondModel.isSelected = false;
            sl.selectedLeftSecondModel = sl.selectedLeftModel.subCategories.firstObject;
            if (sl.selectedLeftSecondModel) {
                sl.selectedLeftSecondModel.isSelected = true;
            }else{
                sl.selectedLeftSecondModel = nil;
            }
            [tableView reloadData];
            
            ///处理图片
            [self addImageView];
            
            ///发送请求
            [sl loadRightData];
        };
        
        return headView;
    }else{
        SMSortRightHeadView* headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:resuSMSortRightHeadView];
        if (self.selectedLeftModel != self.leftDataSource.firstObject && self.rightDataSource.count > 1) {
            headView.model = self.rightDataSource[section];
            headView.hidden = false;
        }else{
            headView.hidden = true;
        }
        return headView;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        SMSortTwoLeftCell*  cell =  [tableView dequeueReusableCellWithIdentifier:resuSMSortTwoLeftCell forIndexPath:indexPath];
        SMSortModel* model = self.leftDataSource[indexPath.section];
        cell.model = model.subCategories[indexPath.row];
        return cell;
    }else{
        SMSortTwoRightCell* cell = [tableView dequeueReusableCellWithIdentifier:resuSMSortTwoRightCell forIndexPath:indexPath];
        if (self.selectedLeftModel == self.leftDataSource.firstObject) {
            cell.model = self.rightDataSource[indexPath.row];
        }else{
            SMSortModel* sortModel = self.rightDataSource[indexPath.section];
            cell.model = sortModel.twoSortDataSource[indexPath.row];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 50;
    }else{
        if (self.selectedLeftModel != self.leftDataSource.firstObject && self.rightDataSource.count > 1) {
            return 50;
        }else{
            return 0.01;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        return 50;
    }else{
        return 115;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        self.selectedLeftSecondModel.isSelected = false;
        SMSortModel *model = self.leftDataSource[indexPath.section];
        SMSortModel *secondmodel = model.subCategories[indexPath.row];
        self.selectedLeftSecondModel = secondmodel;
        self.selectedLeftSecondModel.isSelected = true;
        [tableView reloadData];
        if (self.selectedLeftModel.subCategories.count > 1 && secondmodel.twoSortDataSource.count) {
            [self.rightTableView  scrollToRowAtIndexPath:[NSIndexPath  indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:false];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.rightTableView) {
        if (self.selectedLeftModel.subCategories.count > 1) {
            NSArray * visible = [self.rightTableView indexPathsForVisibleRows];
            NSIndexPath * indexpath = (NSIndexPath*)visible.firstObject;
            if (indexpath) {
                self.selectedLeftSecondModel.isSelected = false;
                self.selectedLeftSecondModel = self.selectedLeftModel.subCategories[indexpath.section];
                self.selectedLeftSecondModel.isSelected = true;
                [self.leftTableView reloadData];
            }
        }
    }
}
// MARK: - ==============懒加载==============
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView  alloc]  initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = [UIColor getColorWithHexString:@"0xf7f7f7"];
        _leftTableView.showsVerticalScrollIndicator = false;
        _leftTableView.showsHorizontalScrollIndicator = false;
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_leftTableView registerNib:[UINib  nibWithNibName:@"SMSortLeftHeadView" bundle:nil] forHeaderFooterViewReuseIdentifier:resuSMSortLeftHeadView];
        [_leftTableView registerNib:[UINib  nibWithNibName:@"SMSortTwoLeftCell" bundle:nil] forCellReuseIdentifier:resuSMSortTwoLeftCell];
    }
    return _leftTableView;
}
-(NSMutableArray *)leftDataSource{
    if (!_leftDataSource) {
        _leftDataSource = [NSMutableArray  array];
    }
    return _leftDataSource;
}
-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView  alloc]  initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.showsVerticalScrollIndicator = false;
        _rightTableView.showsHorizontalScrollIndicator = false;
        _rightTableView.tableFooterView = [[UIView alloc]  init];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_rightTableView registerNib:[UINib  nibWithNibName:@"SMSortRightHeadView" bundle:nil] forHeaderFooterViewReuseIdentifier:resuSMSortRightHeadView];
        [_rightTableView registerNib:[UINib  nibWithNibName:@"SMSortTwoRightCell" bundle:nil] forCellReuseIdentifier:resuSMSortTwoRightCell];
    }
    return _rightTableView;
}
-(NSMutableArray *)rightDataSource{
    if (!_rightDataSource) {
        _rightDataSource = [NSMutableArray  array];
    }
    return _rightDataSource;
}

-(NSMutableArray *)sortDataSource{
    if (!_sortDataSource) {
        _sortDataSource = [NSMutableArray  array];
    }
    return _sortDataSource;
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView  alloc]  initWithFrame:CGRectZero];
        _headImageView.frame = CGRectMake(105, kNavBarHeight+10,  ScreenWidth-115, (ScreenWidth-115)*89/261);
        [self.view addSubview:_headImageView];
        _headImageView.userInteractionEnabled = true;
    }
    return _headImageView;
}

-(void)addImageView{
    if (self.selectedLeftModel.adImage.length > 2) {
        self.headImageView.hidden = false;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.selectedLeftModel.adImage]];
        CGFloat y = CGRectGetMaxY(self.headImageView.frame)+20;
        self.rightTableView.frame = CGRectMake(95, y, ScreenWidth-95, ScreenHeight-y-SafeAreaBottomHeight);
    }else{
        self.headImageView.hidden = true;
        self.rightTableView.frame = CGRectMake(95, kNavBarHeight, ScreenWidth-95, ScreenHeight-kNavBarHeight-SafeAreaBottomHeight);
    }
}

@end
