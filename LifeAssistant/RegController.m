//
//  RegController.m
//  Guru
//
//  Created by pengfei on 16/4/15.
//  Copyright © 2016年 com.techwolf.guru. All rights reserved.
//

#import "RegController.h"
#import <AVUser.h>

@interface RegController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation RegController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

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
    [YFEasyHUD showIndicator];
    [self.view endEditing:YES];
    
    AVUser *user = [AVUser user];
    user.username = self.phoneTF.text;
    user.password = self.pwdTF.text;
    
    NSError *error = nil;
    [user signUp:&error];
    
    if (error) {
        [YFEasyHUD showMsg:@"login error" details:error.localizedDescription lastTime:1.5];
        return;
    }
    
    [YFEasyHUD hideHud];
    
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
