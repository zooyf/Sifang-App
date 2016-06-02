//
//  LoginController.m
//  Guru
//
//  Created by pengfei on 16/4/15.
//  Copyright © 2016年 com.techwolf.guru. All rights reserved.
//

#import "LoginController.h"
#import "FindPSWViewController.h"
#import "RegController.h"
#import <AVUser.h>

@interface LoginController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)regAction:(id)sender;

@end

@implementation LoginController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.loginBtn.layer.cornerRadius = CGRectGetHeight(self.loginBtn.frame)/2.0;
}


- (IBAction)loginAction:(id)sender {
    [YFEasyHUD showIndicator];
    NSString *account = self.accountTF.text;
    NSString *pass = self.passTF.text;
    
    NSError *error = nil;
    [AVUser logInWithUsername:account password:pass error:&error];
        
    if (error) {
        [YFEasyHUD showMsg:@"login error" details:error.localizedDescription lastTime:1.5];
        return;
    }
    
    [YFEasyHUD hideHud];
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

- (IBAction)regAction:(id)sender {
    RegController *reg = [[RegController alloc] initWithNibName:@"RegController" bundle:nil];
    [self.navigationController pushViewController:reg animated:YES];
}
@end
