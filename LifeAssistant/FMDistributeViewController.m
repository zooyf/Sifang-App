//
//  FMDistributeViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMDistributeViewController.h"

@interface FMDistributeViewController ()

@end

@implementation FMDistributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelAction:(id)sender {
    kWEAK
    UIAlertController *cancelAlert = [UIAlertController alertControllerWithTitle:@"放弃发布商品"
                                                                         message:@"填写的信息将不会被保存"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *abortAction = [UIAlertAction actionWithTitle:@"放弃"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"继续发布"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [cancelAlert addAction:abortAction];
    [cancelAlert addAction:continueAction];
    
    [self presentViewController:cancelAlert animated:YES completion:nil];
}

- (IBAction)distributeAction:(id)sender {
    
    
    
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
