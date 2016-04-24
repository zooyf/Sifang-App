//
//  FMDistributeViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMDistributeViewController.h"
#import "YFPhotoPickerView.h"

@interface FMDistributeTFCell ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FMDistributeTFCell

- (NSString *)contentText {
    return self.textField.text;
}

@end

@interface FMDistributeTVCell ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation FMDistributeTVCell

- (NSString *)contentText {
    return self.textView.text;
}

@end


#pragma mark -- FMDistributeViewController --

@interface FMDistributeViewController ()<UITableViewDelegate, UITableViewDataSource, YFPhotoPickerViewDelegate>

@property (nonatomic, strong) NSArray *titleArr;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FMDistributeViewController
NSString * const kPriceName      = @"价格：";
NSString * const kProductName    = @"商品名称：";
NSString * const kDescName       = @"描述：";
NSString * const kPlaceName      = @"交易地点：";
NSString * const kPhoneNumber    = @"手机号：";
NSString * const kQQNumber       = @"QQ号：";
NSString * const kKindName       = @"选择分类：";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"FMDisHeaderView" owner:self options:nil].firstObject;
    [headerView setFrame:CGRectMake(CGRectGetMinX(self.tableView.frame), CGRectGetMinY(self.tableView.frame), kScreenWidth, kScreenWidth/3.0)];
    self.tableView.tableHeaderView = headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    YFPhotoPickerView *pickerView = headerView.subviews.firstObject;
    pickerView.delegate = self;
    
    
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelAction:(id)sender {
    [self.view endEditing:YES];
    
    kWEAK
    UIAlertController *cancelAlert = [UIAlertController alertControllerWithTitle:@"放弃发布商品"
                                                                         message:@"填写的信息将不会被保存"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *abortAction = [UIAlertAction actionWithTitle:@"放弃"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"继续发布"
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [cancelAlert addAction:abortAction];
    [cancelAlert addAction:continueAction];
    
    [self presentViewController:cancelAlert animated:YES completion:nil];
}

- (IBAction)distributeAction:(id)sender {
    [self.view endEditing:YES];

}

- (IBAction)tapToEndEditing:(id)sender {
    [self.view endEditing:YES];
}


#pragma mark -- UITableViewDelegate & UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = self.titleArr[indexPath.row];
    
    NSString *reuseID = kFMDistributeTFCell;    //textField cell
    
    // textView cell
    if ([text isEqualToString:kDescName]) {
        reuseID = kFMDistributeTVCell;
    }
    
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    [cell titleLabel].text = self.titleArr[indexPath.row];
    
    // set keyboard type to Number Pad
    if ([[cell titleLabel].text isEqualToString:kPriceName] || [[cell titleLabel].text isEqualToString:kQQNumber] || [[cell titleLabel].text isEqualToString:kPhoneNumber]) {
        [[cell textField] setKeyboardType:UIKeyboardTypeNumberPad];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // disable textField of kKindName
    if ([text isEqualToString:kKindName]) {
        [[cell textField] setEnabled:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view endEditing:YES];
    
    if ([self.titleArr[indexPath.row] isEqualToString:kKindName]) {
        
    }

}


#pragma mark -- Lazily --

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[
                      kProductName,
                      kPriceName,
                      kDescName,
                      kPlaceName,
                      kPhoneNumber,
                      kQQNumber,
                      kKindName
                      ];
    }
    return _titleArr;
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
