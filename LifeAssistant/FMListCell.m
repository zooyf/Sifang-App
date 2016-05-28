//
//  FMListCell.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMListCell.h"

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
        NSLog(@"%@", image);
    }];
}

@end
