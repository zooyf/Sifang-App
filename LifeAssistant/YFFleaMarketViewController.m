//
//  YFFleaMarketViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/9.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFFleaMarketViewController.h"

@interface YFFleaMarketViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation YFFleaMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark -- UICollectionViewDataSource --

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FleaCell" forIndexPath:indexPath];
    
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
