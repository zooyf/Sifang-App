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

@property (nonatomic, strong) MOStallListViewController *stallListVC;

@end

@implementation YFMealViewController
- (MOStallListViewController *)stallListVC {
    if (!_stallListVC) {
        NSArray *childVCs = self.childViewControllers;
        for (id childController in childVCs) {
            if ([childController isKindOfClass:[MOStallListViewController class]]) {
                _stallListVC = childVCs.firstObject;
                _stallListVC.favourite = NO;
                break;
            }
        }
    }
    return _stallListVC;
}

- (void)setRestaurant:(Restaurant *)restaurant {
    _restaurant = restaurant;
    self.title = restaurant.name;
    
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    
    [self.stallListVC setCurrentRestaurant:restaurant];
    [AppConfig setCurrentRestaurant:restaurant];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = self.restaurant ? YES : NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCurrentRestaurant:) name:kPostNotificationStallListRefresh object:self.restaurant];
    
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
    
    IMP_BLOCK_SELF(YFMealViewController)
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [YFEasyHUD hideHud];
        
        if (error) {
            [YFEasyHUD showMsg:@"请求失败" details:@"请检查网络" lastTime:2];
            [block_self.navigationItem.rightBarButtonItem setEnabled:NO];
            return;
        }
        self.restaurant = objects.firstObject;
    }];
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

- (void)dealloc
{
    [self removeObserver:self forKeyPath:kPostNotificationStallListRefresh];
}

@end
