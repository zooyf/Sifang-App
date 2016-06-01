//
//  MORestaurantListViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "MORestaurantListViewController.h"
#import "InputViewController.h"
#import "Restaurant.h"
#import <MJRefresh.h>

@interface MORestaurantListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

static skip = 0;
@implementation MORestaurantListViewController
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 100;
    
    IMP_BLOCK_SELF(MORestaurantListViewController)
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [block_self requestData];
    }];
    
    [self.tableView.mj_header beginRefreshing];

    if ([AppConfig isManagerUser]) {
        UIBarButtonItem *rightBI = [[UIBarButtonItem alloc] initWithTitle:@"添加餐厅" style:UIBarButtonItemStylePlain target:self action:@selector(addRestaurant)];
        self.navigationItem.rightBarButtonItem = rightBI;
    }
    
    if (self.forceSelect) {
        [YFEasyHUD showMsg:@"选择餐厅" details:@"您还未选择餐厅，请选择" lastTime:2.0];
    }
    
    // Do any additional setup after loading the view.
}

- (void)requestData {
    
    IMP_BLOCK_SELF(MORestaurantListViewController)
    [YFEasyHUD showIndicator];
    AVQuery *query = [AVQuery queryWithClassName:@"Restaurant"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [YFEasyHUD hideHud];
        [block_self.tableView.mj_header endRefreshing];
        if (error) {
            [YFEasyHUD showMsg:@"获取列表失败" details:@"请检查您的网络" lastTime:2];
            [block_self.navigationItem.rightBarButtonItem setEnabled:NO];
            return ;
        }
        
        [block_self.navigationItem.rightBarButtonItem setEnabled:YES];
        if (skip == 0) {
            [block_self.dataList removeAllObjects];
        }
        if (objects && objects.count) {
            [block_self.dataList addObjectsFromArray:objects];
            [block_self.tableView reloadData];
        }
    }];
}

- (void)addRestaurant {
    
    IMP_BLOCK_SELF(MORestaurantListViewController)
    
    InputViewController *inputVC = [[InputViewController alloc] init];
    inputVC.placeHolder = @"请输入餐厅名称";
    [inputVC setRightActionBlock:^BOOL(NSString *str) {
        Restaurant *restaurant = [Restaurant object];
        restaurant.name = str;
        restaurant.rCode = @(arc4random() % 65536);
        NSError *error = nil;
        [restaurant save:&error];
        
        if (error) {
            [YFEasyHUD showMsg:@"添加失败" details:@"请检查网络" lastTime:1.5];
            return false;
        }
        
        [YFEasyHUD showMsg:@"添加成功" details:nil lastTime:1.5];
        [block_self.dataList addObject:restaurant];
        [block_self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[block_self.tableView numberOfRowsInSection:0] inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [block_self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:block_self.dataList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        return true;
    }];
    
    [self.navigationController pushViewController:inputVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDelegate& UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MORestListCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MORestListCell"];
    }
    
    Restaurant *cat = self.dataList[indexPath.row];
    cell.textLabel.text = cat.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BlockCallWithOneArg(self.selectionBlock, self.dataList[indexPath.row]);
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 编辑tableview cell --

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Restaurant *deleting = self.dataList[indexPath.row];
        IMP_BLOCK_SELF(MORestaurantListViewController)
        [YFEasyHUD showIndicator];
        [deleting deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [YFEasyHUD hideHud];
            
            if (error) {
                [YFEasyHUD showMsg:@"删除失败,请重试!" details:nil lastTime:1.5];
                return;
            }
            
            [YFEasyHUD showMsg:@"删除成功" details:nil lastTime:1.5];
            [block_self.dataList removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
    }
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
