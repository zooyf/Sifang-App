//
//  MOStallListViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "MOStallListViewController.h"
#import "MOFoodListViewController.h"

#import "Restaurant.h"
#import "Stall.h"

@interface MOStallListCell : UITableViewCell {
    Stall *_stall;
}
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *desTF;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;

@property (nonatomic, strong) Stall *stall;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MOStallListCell
- (UITableView *)tableView {
    if (!_tableView) {
        id view = [self superview];
        
        while (view && [view isKindOfClass:[UITableView class]] == NO) {
            view = [view superview];
        }

        _tableView = view;
    }
    return _tableView;
}

- (void)setStall:(Stall *)stall {
    _stall = stall;
    
    self.nameTF.text = stall.name;
    self.desTF.text = stall.major_business;
    self.numberLB.text = S(@"%@号", stall.number);
    AVFile *imgFile = [AVFile fileWithURL:stall.image_url];
    
    IMP_BLOCK_SELF(MOStallListCell)
    
    [imgFile getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        if (image) {
            [block_self.imgView setImage:image];
        }
    }];
}

- (void)awakeFromNib {
    BOOL isManager = [AppConfig isManagerUser];
    self.editBtn.hidden = !isManager;
    self.cancelBtn.hidden = YES;
    self.desTF.enabled = NO;
    self.nameTF.enabled = NO;
}

- (IBAction)editAction:(id)sender {
    [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    [self.tableView setAllowsSelection:NO];
    
    [self setSelected:NO];
    
    self.nameTF.enabled = YES;
    self.desTF.enabled = YES;
    
    self.numberLB.hidden = YES;
    self.cancelBtn.hidden = NO;
    
    [self.editBtn removeTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn addTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nameTF becomeFirstResponder];
}

- (void)completeAction {
    [YFEasyHUD showIndicator];
    if (StringIsNullOrEmpty(self.desTF.text)) {
        [YFEasyHUD showMsg:@"修改失败" details:@"请输入档口简介" lastTime:1.5];
        return;
    }
    if (StringIsNullOrEmpty(self.nameTF.text)) {
        [YFEasyHUD showMsg:@"修改失败" details:@"请输入档口名" lastTime:1.5];
        return;
    }
    
    self.stall.name = self.nameTF.text;
    self.stall.major_business = self.desTF.text;
    NSError *error = nil;
    [self.stall save:&error];
    
    if (error) {
        [YFEasyHUD showMsg:@"修改失败" details:@"请检查网络" lastTime:1.5];
    } else {
        [YFEasyHUD showMsg:@"修改成功" details:nil lastTime:1.5];
    }
    
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [self cancelAction:nil];
    
    [self.editBtn removeTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.tableView setAllowsSelection:YES];
}

- (IBAction)cancelAction:(id)sender {
    [self.contentView endEditing:YES];
    
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn removeTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];

    self.numberLB.hidden = NO;
    self.cancelBtn.hidden = YES;
    
    self.nameTF.text = self.stall.name;
    self.desTF.text = self.stall.major_business;
    
    self.nameTF.enabled = NO;
    self.desTF.enabled = NO;
    
    [self.tableView setAllowsSelection:YES];
}

@end


#pragma mark ---------- MOStallListViewController ----------

@interface MOStallListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *noStallLabel;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

static int limit = 15;
static int skip = 0;

@implementation MOStallListViewController
- (void)setCurrentRestaurant:(Restaurant *)currentRestaurant {
    _currentRestaurant = currentRestaurant;
    
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestData) name:kPostNotificationStallListRefresh object:nil];
    
    IMP_BLOCK_SELF(MOStallListViewController)
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        skip = 0;
        [block_self requestData];
    }];
    
    self.tableView.tableFooterView = [UIView new];
    // Do any additional setup after loading the view.
}

- (void)requestData {
    AVQuery *query = [AVQuery queryWithClassName:kStallName];
    
    if (!self.favourite) {
        if (self.currentRestaurant) {
            [query whereKey:@"restaurant" equalTo:self.currentRestaurant];
        } else {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer setHidden:YES];
            return;
        }
    }
//    //查找我的收藏逻辑未完成
//    if (self.favourite) {
//        [query whereKey:@"seller" equalTo:[AVUser currentUser]];
//    }
    IMP_BLOCK_SELF(MOStallListViewController)
    
    query.limit = limit;
    query.skip = skip;
    
    [YFEasyHUD showIndicator];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [YFEasyHUD hideHud];
        
        [block_self.tableView.mj_header endRefreshing];
        [block_self.tableView.mj_footer endRefreshing];
        
        if (error) {
            [YFEasyHUD showMsg:@"请求失败" details:@"请检查网络" lastTime:1.5];
            [block_self.tableView.mj_footer setHidden:YES];
            return ;
        } else {
            [block_self.tableView.mj_footer setHidden:NO];
        }
        
        if (skip == 0) {
            [block_self.dataList removeAllObjects];
        }
        
        [block_self.dataList addObjectsFromArray:objects];
        [block_self.tableView reloadData];
        
        if (block_self.dataList.count == 0) {
            block_self.tableView.mj_footer = nil;
            return;
        }
        if (!block_self.tableView.mj_footer) {
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:block_self refreshingAction:@selector(requestData)];
        }
        if (objects.count < limit) {
            [block_self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        skip += limit;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDataSource & UITableViewDelegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = self.dataList.count;
    self.noStallLabel.hidden = count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MOStallListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MOStallsListCell"];
    
    cell.stall = self.dataList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destiVC = segue.destinationViewController;
    [destiVC setHidesBottomBarWhenPushed:YES];
    
    if ([destiVC isKindOfClass:[MOFoodListViewController class]]) {
        
        [destiVC setStall:[sender stall]];
    }
    
}

@end
