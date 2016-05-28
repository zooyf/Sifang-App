//
//  FleaListViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMListViewController.h"
#import "FMDetailTableViewController.h"
//#import "FMListCell.h"

@interface FMListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation FMListCell

- (void)setProduct:(Product *)product {
    
    _product = product;
    
    self.titleLabel.text = product.title;
    self.detailLabel.text = product.describe;
    self.priceLabel.text = product.price;
    
    IMP_BLOCK_SELF(FMListCell)
    AVFile *file = [AVFile fileWithURL:product.imageUrl];
    
    [file getThumbnail:YES width:100 height:100 withBlock:^(UIImage *image, NSError *error) {
        [block_self.imgView setImage:image];
    }];
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
    
//    [self.tableView registerNib:[UINib nibWithNibName:kFMListCell bundle:nil] forCellReuseIdentifier:kFMListCell];
    
    [self query];
    
    // Do any additional setup after loading the view.
}

- (void)query {
    
    IMP_BLOCK_SELF(FMListViewController)
    
    AVQuery *query = [AVQuery queryWithClassName:kAVProductName];
    
    [query whereKey:@"kind" equalTo:self.kind];
    
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
    
    FMListCell *cell = [tableView dequeueReusableCellWithIdentifier:kFMListCell];
    
    [cell setProduct:self.dataList[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([sender isKindOfClass:[FMListCell class]]) {
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
