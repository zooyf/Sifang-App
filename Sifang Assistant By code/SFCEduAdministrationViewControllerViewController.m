//
//  SFCEduAdministrationViewControllerViewController.m
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/5.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import "SFCEduAdministrationViewControllerViewController.h"

@interface SFCEduAdministrationViewControllerViewController ()

@end

@implementation SFCEduAdministrationViewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = NO;
    self.view = webView;
    self.view.backgroundColor = [UIColor whiteColor];
    NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
    [(UIWebView *)self.view loadRequest:req];
//     Do any additional setup after loading the view from its nib.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"教务系统";
        self.tabBarItem.title = @"教务系统";

    }
    NSString *requestString = @"http://10.2.88.9";
    _URL = [NSURL URLWithString:requestString];

    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
