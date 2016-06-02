//
//  YFMineViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/6/2.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFMineViewController.h"
#import "MYInfoController.h"
#import "MYUnLoginController.h"

@interface YFMineViewController ()
@property (weak, nonatomic) IBOutlet UIView *loggedView;
@property (weak, nonatomic) IBOutlet UIView *unLoginView;

@property (nonatomic, strong) MYInfoController *infoController;
@property (nonatomic, strong) MYUnLoginController *unloginController;

@property (nonatomic, strong) UIBarButtonItem *item;
@end

@implementation YFMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    void(^changeView)() = ^() {
        self.loggedView.hidden = !self.loggedView.hidden;
        self.unLoginView.hidden = !self.unLoginView.hidden;
        [self.view endEditing:YES];
        if (self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        } else {
            self.navigationItem.leftBarButtonItem = self.item;
        }
    };
    
    self.infoController.logoutBlock = changeView;
    
    self.item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self.infoController action:self.infoController.selEditAction];
    self.navigationItem.leftBarButtonItem = self.item;

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.loggedView.hidden = ![AVUser currentUser];
    self.unLoginView.hidden = [AVUser currentUser];
    if ([AppConfig isManagerUser]) {
        self.navigationItem.leftBarButtonItem = self.item;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destinationController = segue.destinationViewController;
    if ([destinationController isKindOfClass:[MYInfoController class]]) {
        self.infoController = destinationController;
    }
    if ([destinationController isKindOfClass:[MYUnLoginController class]]) {
        self.unloginController = destinationController;
    }
}

@end
