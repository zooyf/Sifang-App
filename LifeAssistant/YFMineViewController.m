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

@end

@implementation YFMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDataSource&Delegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:kMYHeadCell];
    cell.nameLabel.text = @"hahaha";
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
