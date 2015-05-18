//
//  SFCLibraryViewController.m
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/5.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import "SFCLibraryViewController.h"

@interface SFCLibraryViewController ()

@end

@implementation SFCLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"图书馆";
        self.tabBarItem.title = @"图书馆";
        UIImage *image = [UIImage imageNamed:@"Timetable.png"];
        
        self.tabBarItem.image = image;
    }
    
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
