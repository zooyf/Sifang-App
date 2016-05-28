//
//  InputViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/29.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "InputViewController.h"
#import "Restaurant.h"

@interface InputViewController ()

@property (nonatomic, strong) UITextField *tfSingle;

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 40)];
    [self.view addSubview:txtField];
    txtField.placeholder = self.placeHolder;
    self.tfSingle = txtField;
    
    UIBarButtonItem *backBI= [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UIBarButtonItem *saveBI = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    
    self.navigationItem.leftBarButtonItem = backBI;
    self.navigationItem.rightBarButtonItem = saveBI;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAction {
    
    if (StringIsNullOrEmpty(self.tfSingle.text)) {
        [YFEasyHUD showMsg:@"请输入内容" details:nil lastTime:1.5];
        return;
    }
    
    BlockCallWithOneArg(self.rightActionBlock, self.tfSingle.text)
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
