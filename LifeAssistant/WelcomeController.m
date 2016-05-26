//
//  WelcomeController.m
//  Guru
//
//  Created by pengfei on 16/4/15.
//  Copyright © 2016年 com.techwolf.guru. All rights reserved.
//

#import "WelcomeController.h"

@interface WelcomeController ()



@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goLogin:(UIButton *)sender {
    
    self.login = [[LoginController alloc]initWithNibName:@"LoginController" bundle:nil];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationController pushViewController:self.login animated:YES];
    
}

- (IBAction)goReg:(UIButton *)sender {
    
    self.reg = [[RegController alloc] initWithNibName:@"RegController" bundle:nil];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationController pushViewController:self.reg animated:YES];

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
