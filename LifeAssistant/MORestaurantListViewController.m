//
//  MORestaurantListViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "MORestaurantListViewController.h"

@interface MORestaurantListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MORestaurantListViewController

- (NSArray *)arrCellName {
    return @[@"第一食堂",@"第二食堂", @"第三食堂", @"第四食堂", @"独立餐厅"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDelegate& UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self arrCellName].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MORestListCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MORestListCell"];
    }
    
    cell.textLabel.text = [self arrCellName][indexPath.row];
    
    return cell;
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
