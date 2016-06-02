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
@property (weak, nonatomic) IBOutlet UITableViewCell *detailCell;


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
    self.timeLabel.text = [product.createdAt stringDateWithFormat:@"y-M-d hh:mm"];
    self.addressLabel.text = product.deal_location;
    
    AVUser *user = product.seller;
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    
    [query getObjectInBackgroundWithId:user.objectId block:^(AVObject *object, NSError *error) {
        AVUser *user = (AVUser *)object;
        block_self.sellerNameLabel.text = user.name;
        block_self.gradeLabel.text = user.grade;
    }];
    
    [user.avatar getThumbnail:YES width:50 height:50 withBlock:^(UIImage *image, NSError *error) {
        if (image) {
            [block_self.sellerAvatarView setImage:image];
        }
    }];
    
    self.gradeLabel.text = @"大一";
    self.detailCell.textLabel.text = product.describe;
    
    // Do any additional setup after loading the view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
