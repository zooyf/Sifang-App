//
//  FMDetailTableViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/28.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMDetailTableViewController.h"

@interface FMDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sellerAvatarView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation FMDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setAllowsSelection:NO];
    
    IMP_BLOCK_SELF(FMDetailTableViewController)
    AVFile *imageFile = [AVFile fileWithURL:self.product.imageUrl];
    
    [imageFile getThumbnail:NO width:ScreenWidth height:ScreenHeight withBlock:^(UIImage *image, NSError *error) {
        if (image) {
            [block_self.imageView setImage:image];
        }
    }];;
    
    Product *product = self.product;
    self.proName.text = product.title;
    self.priceLabel.text = product.price;
    self.timeLabel.text = [product.createdAt stringDateWithFormat:@"yy年M月d日"];
    self.addressLabel.text = product.deal_location;
    
    AVUser *user = product.seller;
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    
    [query getObjectInBackgroundWithId:user.objectId block:^(AVObject *object, NSError *error) {
        AVUser *user = (AVUser *)object;
        block_self.sellerNameLabel.text = user.name;
        block_self.gradeLabel.text = user.grade;
        block_self.gradeLabel.text = user.grade;
        self.detailLabel.text = self.product.describe;
        [block_self.tableView reloadData];
    }];
    
    [user.avatar getThumbnail:YES width:50 height:50 withBlock:^(UIImage *image, NSError *error) {
        if (image) {
            [block_self.sellerAvatarView setImage:image];
        }
    }];
    
    self.detailLabel.text = self.product.describe;
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 2 ? 30: 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 20)];
    [label setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:label];
    
    if (section == 1) {
        label.text = @"卖家信息";
        return view;

    }
    if (section == 2) {
        label.text = @"商品详情";
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 220;
                break;
                
            case 1:
                return 110;
                break;
                
            default:
                return 60;
                break;
        }
        
    }
    if (indexPath.section == 1) {
        return 55;
    }
    
    if (indexPath.section == 2) {
        UILabel *label = self.detailLabel;
        CGRect rect = [NSString heightForString:self.product.describe Size:CGSizeMake(ScreenWidth - 40, 400) Font:label.font];
        return rect.size.height + 25;
    }
    
    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
