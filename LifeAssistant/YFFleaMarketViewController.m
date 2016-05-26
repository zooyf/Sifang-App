//
//  YFFleaMarketViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/9.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFFleaMarketViewController.h"
#import "WelcomeController.h"

@interface FleaCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end

@implementation FleaCollectionCell



@end

@interface YFFleaMarketViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation YFFleaMarketViewController

- (NSArray *)cellTitleArr {
    return @[@"数码配件", @"数码", @"手机", @"电脑",
             @"校园代步", @"电器", @"运动健身", @"衣物伞冒",
             @"图书教材", @"租赁", @"生活娱乐", @"其他"];
}

- (NSArray *)cellSubTitleArr {
    return @[
             @"耳机 U盘 键盘", @"iPad 相机 游戏机", @"iphone 小米 三星", @"联想 戴尔 Mac",
             @"自行车 电动车", @"电扇 台灯 饮水机", @"篮球 足球 球拍", @"上衣 裤子 帽子",
             @"教材 考研 课外书", @"租房 服装 道具", @"乐器 日常 会员卡", @"可能有你想要的"
            ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    if (![AppConfig checkBaseInfo]) {
        WelcomeController *welcom = [[WelcomeController alloc] initWithNibName:@"WelcomeController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:welcom];
        
        // 解决
        dispatch_async(dispatch_get_main_queue(), ^(void){
//            [self.container presentModalViewController:nc animated:YES];
            [self.tabBarController presentViewController:nav animated:NO completion:nil];
        });
    }
}


#pragma mark -- UICollectionViewDataSource --

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FleaCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FleaCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = [self cellTitleArr][indexPath.row];
    cell.subLabel.text = [self cellSubTitleArr][indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}


#pragma mark -- UICollectionViewDelegateFlowLayout --

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = kScreenWidth/2-15;
    CGFloat height = kScreenHeight-kTabBarHeight-kNavigationBarHeight;
    height/=6;
    height-=12;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
