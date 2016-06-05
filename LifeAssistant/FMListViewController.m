//
//  FleaListViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMListViewController.h"
#import "FMDetailTableViewController.h"
#import "FMDistributeViewController.h"

#define kFMListCell @"FMListCell"
#define kMYDistributeCell @"MYDistributeCell"

@interface FMListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property(nonatomic, strong) Product *product;

@end

@implementation FMListCell

- (void)setProduct:(Product *)product {
    
    _product = product;
    
    self.titleLabel.text = product.title;
    self.detailLabel.text = product.describe;
    self.priceLabel.text = S(@"￥%@", product.price);
    
    IMP_BLOCK_SELF(FMListCell)
    AVFile *file = [AVFile fileWithURL:product.imageUrl];
    
    [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        [block_self.imgView setImage:image];
    }];
}

@end



#pragma mark -- DistributeCell --


@interface MYDistributeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIButton *distributeBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, strong) Product *product;

@property (nonatomic, copy) void(^editBlock)(Product *product, int buttonClick);

@end

@implementation MYDistributeCell
- (void)awakeFromNib {
    self.titleLabel.text = self.product.title;
    
    [self.editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.distributeBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setProduct:(Product *)product {
    _product = product;
    
    IMP_BLOCK_SELF(MYDistributeCell)
    AVFile *file = [AVFile fileWithURL:product.imageUrl];
    [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        [block_self.imgView setImage:image];
    }];
    [self setupUIByStatus:[product.saleStatus intValue]];
}

- (void)setupUIByStatus:(ProductStatus)status {
    self.titleLabel.text = self.product.title;
    switch (status) {
        case ProductStatusOnSale:{
            self.detailLabel.text = @"正在出售";
            [self.detailLabel setTextColor:[UIColor greenColor]];
            [self.editBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.editBtn.hidden = NO;
            self.distributeBtn.hidden = NO;
            [self.distributeBtn setTitle:@"下架" forState:UIControlStateNormal];
            [self.distributeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }break;
            
        case ProductStatusOffSale: {
            self.detailLabel.text = @"已下架";
            [self.detailLabel setTextColor:[UIColor lightGrayColor]];
            self.editBtn.hidden = YES;
            self.distributeBtn.hidden = NO;
            [self.distributeBtn setTitle:@"重新上架" forState:UIControlStateNormal];
            [self.distributeBtn setTitleColor:[UIColor colorWithRed:0.400 green:0.800 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
        }break;
            
        case ProductStatusSoldOut: {
            self.detailLabel.text = @"已售出";
            [self.detailLabel setTextColor:[UIColor lightGrayColor]];
            self.distributeBtn.hidden =YES;
            self.editBtn.hidden = YES;
            
        }break;
            
        default:
            break;
    }
}

- (void)edit:(UIButton *)button {
    int buttonNum;
    if ([button.currentTitle isEqualToString:@"编辑"]) {
        buttonNum = 1;
    } else if([button.currentTitle isEqualToString:@"下架"]) {
        buttonNum = 0;
    } else {
        buttonNum = 2;
    }
    self.editBlock(self.product, buttonNum);
}

@end



#pragma mark -- FMListViewController --

@interface FMListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation FMListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self query];
    
    // Do any additional setup after loading the view.
}

- (void)query {
    
    IMP_BLOCK_SELF(FMListViewController)
    
    AVQuery *query = [AVQuery queryWithClassName:kAVProductName];
    
    if (self.kind) {
        [query whereKey:@"kind" equalTo:self.kind];
    }
    if (!self.myDistributeProduct) {
        [query whereKey:@"saleStatus" equalTo:@(ProductStatusOnSale)];
    } else {
        [query whereKey:@"seller" equalTo:[AVUser currentUser]];
    }
    
    [YFEasyHUD showIndicator];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [YFEasyHUD hideHud];
        
        if (error) {
            [YFEasyHUD showMsg:@"请求失败" details:@"请检查网络" lastTime:2];
            return ;
        }
        if (objects && objects.count) {
            [block_self.dataList addObjectsFromArray:objects];
            [block_self.tableView reloadData];
            return;
        }
        [YFEasyHUD showMsg:@"暂无数据" details:nil lastTime:2];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDataSource&UITableViewDelegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = [tableView dequeueReusableCellWithIdentifier:self.myDistributeProduct ? kMYDistributeCell : kFMListCell];
    
    [cell setProduct:self.dataList[indexPath.row]];
    
    IMP_BLOCK_SELF(FMListViewController)
    if ([cell isKindOfClass:[MYDistributeCell class]]) {
        
        [cell setEditBlock:^(Product *product, int buttonClick) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            switch (buttonClick) {
                case 0: {   //下架 按钮
                    UIAlertController *offAlert = [UIAlertController alertControllerWithTitle:@"下架" message:@"您的下架原因是什么?" preferredStyle:UIAlertControllerStyleActionSheet];
                    
                    UIAlertAction *soldOutAction = [UIAlertAction actionWithTitle:@"已经卖出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [product setSaleStatus:@2];
                        NSError *error = nil;
                        [YFEasyHUD showIndicator];
                        [product save:&error];
                        if (!error) {
                            [YFEasyHUD showMsg:@"保存成功" details:nil lastTime:2];
                            [block_self.tableView reloadData];
                            return ;
                        }
                        [YFEasyHUD showMsg:@"保存失败" details:@"请检查您的网络" lastTime:2];
                    }];
                    
                    UIAlertAction *offSaleAction = [UIAlertAction actionWithTitle:@"不想卖了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [product setSaleStatus:@0];
                        NSError *error = nil;
                        [YFEasyHUD showIndicator];
                        [product save:&error];
                        if (!error) {
                            [YFEasyHUD showMsg:@"保存成功" details:nil lastTime:2];
                            [block_self.tableView reloadData];
                            return ;
                        }
                        [YFEasyHUD showMsg:@"保存失败" details:@"请检查您的网络" lastTime:2];
                    }];
                    
                    [offAlert addAction:soldOutAction];
                    [offAlert addAction:offSaleAction];
                    [offAlert addAction:cancelAction];
                    
                    [block_self presentViewController:offAlert animated:YES completion:nil];
                    
                }break;
                    
                case 1: {   //编辑  按钮
                    [block_self performSegueWithIdentifier:kFMEditMyDistriSegue sender:product];
                }break;
                    
                case 2:{   // 重新上架  按钮
                    UIAlertController *reDistributeAlert = [UIAlertController alertControllerWithTitle:@"商品已下架" message:@"是否重新上架?" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [product setSaleStatus:@(ProductStatusOnSale)];
                        NSError *error = nil;
                        [YFEasyHUD showIndicator];
                        [product save:&error];
                        if (!error) {
                            [YFEasyHUD showMsg:@"保存成功" details:nil lastTime:2];
                            return ;
                        }
                        [YFEasyHUD showMsg:@"保存失败" details:@"请检查您的网络" lastTime:2];
                    }];
                    [reDistributeAlert addAction:cancelAction];
                    [reDistributeAlert addAction:confirmAction];
                    [reDistributeAlert addAction:cancelAction];
                    
                    [block_self presentViewController:reDistributeAlert animated:YES completion:nil];
                }break;
                    
                default:
                    break;
            }
        }];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:kFMList2DetailSegue sender:[tableView cellForRowAtIndexPath:indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destinationController = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:kFMList2DetailSegue]) {
        FMDetailTableViewController *detailVC = segue.destinationViewController;
        if ([detailVC respondsToSelector:@selector(setProduct:)]) {
            [detailVC setProduct:[sender product]];
        }
    }
    
    if ([segue.identifier isEqualToString:kFMEditMyDistriSegue]) {
        [destinationController setProduct:sender];
    }
    
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
