//
//  FindPSWViewController.m
//  Guru
//
//  Created by YesterdayFinder on 16/4/27.
//  Copyright © 2016年 com.techwolf.guru. All rights reserved.
//

#import "FindPSWViewController.h"

@interface FindPSWViewController () {
    int count;
}

@property (weak, nonatomic) IBOutlet UITextField *tfPhone_sign;
@property (weak, nonatomic) IBOutlet UITextField *tfPSW_sign;
@property (weak, nonatomic) IBOutlet UITextField *tfVerCode;

@property (weak, nonatomic) IBOutlet UIButton *btnVer;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation FindPSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitAction:(id)sender {
    
    [self.view endEditing:YES];
    
}

- (IBAction)verAction:(id)sender {
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

@end
