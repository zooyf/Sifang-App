//
//  LoginController.m
//  Guru
//
//  Created by pengfei on 16/4/15.
//  Copyright © 2016年 com.techwolf.guru. All rights reserved.
//

#import "LoginController.h"
#import "FindPSWViewController.h"
#import <AVUser.h>

@interface LoginController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.loginBtn.layer.cornerRadius = CGRectGetHeight(self.loginBtn.frame)/2.0;
}


- (IBAction)loginAction:(id)sender {
    
    NSString *account = self.accountTF.text;
    NSString *pass = self.passTF.text;
    
    NSError *error = nil;
    AVUser *user = [AVUser logInWithUsername:account password:pass error:&error];
    
    if (error) {
        NSString *des = error.localizedDescription;
        return;
    }
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)findPassAction:(id)sender {
    
    FindPSWViewController * find = [[FindPSWViewController alloc] initWithNibName:@"FindPSWViewController" bundle:nil];
    [self.navigationController pushViewController:find animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
