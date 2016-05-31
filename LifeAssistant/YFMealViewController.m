//
//  YFMealViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFMealViewController.h"
#import "MORestaurantListViewController.h"
#import "MOStallListViewController.h"
#import "MOAddStallController.h"
#import "Restaurant.h"

@interface YFMealViewController ()
@property (nonatomic, strong) Restaurant *restaurant;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myFavAction;
@end

@implementation YFMealViewController
- (void)setRestaurant:(Restaurant *)restaurant {
    _restaurant = restaurant;
    
    [AppConfig setCurrentRestaurant:restaurant];
    self.title = restaurant.name;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = self.restaurant ? YES : NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([AppConfig isManagerUser]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加档口" style:UIBarButtonItemStylePlain target:self action:@selector(addStall)];
    } else {
        self.navigationItem.rightBarButtonItem = _myFavAction;
    }
    
    self.restaurant = [AppConfig currentRestaurant];
    if (self.restaurant) {
        self.title = self.restaurant.name;
    } else {
        [self requestRestaurant];
    }
    
    // Do any additional setup after loading the view.
}

- (void)requestRestaurant {
    AVQuery *query = [AVQuery queryWithClassName:kRestaurantName];
    query.limit = 1;
    
    [YFEasyHUD showIndicator];
    
    NSError *error = nil;
    NSArray *arr = [query findObjects:&error];
    if (error) {
        [YFEasyHUD showMsg:@"获取失败" details:@"请检查您的网络" lastTime:2];
        return;
    }
    
    [YFEasyHUD hideHud];
    self.restaurant = arr.firstObject;
    
}

- (void)addStall {
    
    [self performSegueWithIdentifier:@"MEAL2ADDSTALL" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destiVC = segue.destinationViewController;
    [destiVC setHidesBottomBarWhenPushed:YES];
    
    IMP_BLOCK_SELF(YFMealViewController)
    
    if ([destiVC isKindOfClass:[MORestaurantListViewController class]]) {
        if ([sender isKindOfClass:[NSValue class]]) {
            [destiVC setForceSelect:[sender boolValue]];
        }
        [destiVC setSelectionBlock:^(Restaurant *sender) {
            block_self.restaurant = sender;
        }];
    }
    
    if ([destiVC isKindOfClass:[MOAddStallController class]]) {
        [destiVC setCurrentRestaurant:self.restaurant];
    }
    
    if ([segue.identifier isEqualToString:@"MEAL2FAVOURITE"]) {
        [destiVC setFavourite:YES];
    }
}

@end
