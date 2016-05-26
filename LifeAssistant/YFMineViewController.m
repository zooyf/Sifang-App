//
//  YFMineViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/20.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFMineViewController.h"

@interface MYHeadCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MYHeadCell


@end


#pragma mark -- YFMineVC implementation --

@interface YFMineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YFMineViewController

- (NSArray *)arrCellName {
    return @[@[@"avatar"], @[@"我的发布", @"我的收藏"], @[@"美食收藏"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDataSource&Delegate --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self arrCellName].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [([self arrCellName][section]) count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MYHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:kMYHeadCell];
        cell.nameLabel.text = @"hahaha";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MYBodyCell"];
    cell.textLabel.text = [self arrCellName][indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section==1) {
        return @"跳蚤市场";
    }
    if (section==2) {
        return @"美食";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }
    return 60;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
