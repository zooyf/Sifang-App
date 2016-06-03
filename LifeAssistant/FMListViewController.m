//
//  FleaListViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMListViewController.h"
#import "FMDetailTableViewController.h"

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

@end

@implementation MYDistributeCell
- (void)awakeFromNib {
    self.titleLabel.text = self.product.title;
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
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [block_self.dataList addObjectsFromArray:objects];
        [block_self.tableView reloadData];
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
    
    FMListCell *cell = [tableView dequeueReusableCellWithIdentifier:self.myDistributeProduct ? kMYDistributeCell : kFMListCell];
    
    [cell setProduct:self.dataList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:kFMList2DetailSegue sender:[tableView cellForRowAtIndexPath:indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:kFMList2DetailSegue]) {
        FMDetailTableViewController *detailVC = segue.destinationViewController;
        if ([detailVC respondsToSelector:@selector(setProduct:)]) {
            [detailVC setProduct:[sender product]];
        }
    }
    
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
