//
//  MYUnLoginController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/6/2.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "MYUnLoginController.h"
#import "LoginController.h"
#import "RegController.h"

@interface MYUnLoginController ()

- (IBAction)loginAction:(id)sender;
- (IBAction)regAction:(id)sender;

@end

@implementation MYUnLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //未登录显示 登录/注册按钮
    self.loginView.hidden = [AVUser currentUser];
    self.completeView.hidden = !self.loginView.hidden;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)loginAction:(id)sender {
    
    LoginController *login = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    [self.navigationController pushViewController:login animated:YES];
}

- (IBAction)regAction:(id)sender {
    
    RegController *reg = [[RegController alloc] initWithNibName:@"RegController" bundle:nil];
    [self.navigationController pushViewController:reg animated:YES];
}

- (IBAction)completeAction:(id)sender {
    [self.navigationController pushViewController:[YFUtils infoController] animated:YES];
}

@end
