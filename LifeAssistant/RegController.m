//
//  RegController.m
//  Guru
//
//  Created by pengfei on 16/4/15.
//  Copyright © 2016年 com.techwolf.guru. All rights reserved.
//

#import "RegController.h"
#import <AVUser.h>

@interface RegController () {
    int count;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *verCodeTF;

@property (weak, nonatomic) IBOutlet UIButton *btnVer;
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation RegController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    self.btnComplete.layer.cornerRadius = CGRectGetHeight(self.btnComplete.frame)/2.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signAction: (id)sender {
    
    [self.view endEditing:YES];
    
    AVUser *user = [AVUser user];
    user.username = self.phoneTF.text;
    user.password = self.pwdTF.text;
    
    NSError *error = nil;
    [user signUp:&error];
    
    if (error) {
        
        return;
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)sendVerAction:(UIButton *)sender {
    
    
    [self countTimeAction];
    sender.enabled = NO;
}

- (void)countTimeAction {
    
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTimeAction) userInfo:nil repeats:YES];
        count = 60;
        return;
    }
    
    if (!count) {
        [self.btnVer setEnabled:YES];
        [self.btnVer setTitle:S(@"获取验证码") forState:UIControlStateNormal];
        [self.btnVer setTitleColor:[UIColor colorWithRed:0.078 green:0.718 blue:0.973 alpha:1.000] forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    
    [self.btnVer setTitle:S(@"%d", count) forState:UIControlStateNormal];
    [self.btnVer setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    count--;
    
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
