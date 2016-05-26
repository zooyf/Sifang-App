//
//  FMDetailViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMDetailViewController.h"

@interface FMDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMDetailViewController

- (NSArray *)arrCellName {
    return @[@[@"photo", @"productAttr"],@[@"seller"],@[@"des"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView setEstimatedRowHeight:kScreenWidth];
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDelegate&UITableViewDataSource --

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = [NSString stringWithFormat:@"FMDetailCell%ld%ld", indexPath.section, indexPath.row%3];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self arrCellName][section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self arrCellName].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            return kScreenWidth;
        }
        return 110;
    } else if(section == 1) {
        return 60;
    } else {
        return 60;
    }
}

- (IBAction)contactAction:(id)sender {
    
}

- (IBAction)favourAction:(id)sender {
    
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
