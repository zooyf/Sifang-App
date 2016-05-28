//
//  YFMealViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFMealViewController.h"
#import "MORestaurantListViewController.h"
#import "Restaurant.h"

@interface YFMealViewController ()
@property (nonatomic, strong) Restaurant *restaurant;
@end

@implementation YFMealViewController
- (void)setRestaurant:(Restaurant *)restaurant {
    _restaurant = restaurant;
    
    self.title = restaurant.name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destiVC = segue.destinationViewController;
    [destiVC setHidesBottomBarWhenPushed:YES];
    
    IMP_BLOCK_SELF(YFMealViewController)
    
    if ([destiVC isKindOfClass:[MORestaurantListViewController class]]) {
        [destiVC setSelectionBlock:^(Restaurant *sender) {
            block_self.restaurant = sender;
        }];
    }
}

@end
