//
//  YFFleaMarketViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/9.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFFleaMarketViewController.h"
#import "LoginController.h"
#import "FMListViewController.h"
#import "MYInfoController.h"

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(distributeAction)];
    
    [self.tabBarController.tabBar setTranslucent:NO];
    // Do any additional setup after loading the view.
}

- (void)distributeAction {
    
    // 信息不完善或未登录
    if (![AppConfig checkBaseInfo]) {
        
        IMP_BLOCK_SELF(YFFleaMarketViewController)
        NSString *confirmString;
        UIAlertAction *confirmAction;
        if ([AVUser currentUser]) {
            // 信息不完善
            confirmString = @"信息不完善，点击确定去完善信息";
            confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [block_self.navigationController pushViewController:[YFUtils infoController] animated:YES];
                });
            }];
        } else {
            // 未登录
            confirmString = @"您还未登陆，是否登陆？";
            confirmAction = [UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                LoginController *login = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
                
                // 解决unbalanced xxx
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [block_self.navigationController pushViewController:login animated:YES];
                });
            }];
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法发布商品" message:confirmString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [alert addAction:confirmAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    } else {
        //信息完善&已登录
        [self performSegueWithIdentifier:kSegueMarket2Distribute sender:nil];
        
    }
    
}


#pragma mark -- UICollectionViewDataSource --

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FleaCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FleaCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = [AppConfig allKind][indexPath.row];
    cell.subLabel.text = [self cellSubTitleArr][indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self cellSubTitleArr].count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -- UICollectionViewDelegateFlowLayout --

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = ScreenWidth/2-15;
    CGFloat height = ScreenHeight-kTabBarHeight-kNavigationBarHeight;
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
    id destinationController = segue.destinationViewController;
    
    [destinationController setHidesBottomBarWhenPushed:YES];
    
    if ([sender isKindOfClass:[FleaCollectionCell class]]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        FMListViewController *listVC = segue.destinationViewController;
        listVC.kind = @(indexPath.row+1);
        listVC.myDistributeProduct = NO;
    }
        
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
