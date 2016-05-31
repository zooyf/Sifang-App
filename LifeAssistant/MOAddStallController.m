//
//  MOAddStallController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/30.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "MOAddStallController.h"
#import "MOFoodListViewController.h"
#import "YFPhotoPickerView.h"
#import "Stall.h"

@interface MOAddStallController ()<YFPhotoPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *stallNameTF;
@property (weak, nonatomic) IBOutlet UITextField *stallNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *stallDescribeTF;
@property (weak, nonatomic) IBOutlet UITextField *stallAddressTF;
@property (weak, nonatomic) IBOutlet UITextField *stallPhoneTF;
@property (weak, nonatomic) IBOutlet UILabel *stallBelongLB;

@property (nonatomic, strong) YFPhotoPickerView *photoPickerView;
@property (nonatomic, strong) NSString *imageURL;
@end

@implementation MOAddStallController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveStall)];
    
    self.stallBelongLB.text = self.currentRestaurant.name;
    
    // 添加图片视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.tableView.frame), CGRectGetMinY(self.tableView.frame), ScreenWidth, ScreenWidth/3.0)];
    CGFloat pickerViewBorder = headerView.frame.size.height * 0.8;
    self.photoPickerView = [[YFPhotoPickerView alloc] initWithFrame:CGRectMake(0, 0, pickerViewBorder, pickerViewBorder)];
    [self.photoPickerView setImage:[UIImage imageNamed:@"take_photo"]];
    self.photoPickerView.center = headerView.center;
    [headerView addSubview:self.photoPickerView];
    
    self.tableView.tableHeaderView = headerView;
    
    self.photoPickerView = headerView.subviews.firstObject;
    self.photoPickerView.delegate = self;
    
    
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
}

- (void)saveStall {
    
//    if (StringIsNullOrEmpty(self.imageURL)) {
//        [YFEasyHUD showMsg:@"保存失败" details:@"请上传图片" lastTime:1.5];
//        return;
//    }
//    if (StringIsNullOrEmpty(self.stallAddressTF.text)) {
//        [YFEasyHUD showMsg:@"保存失败" details:@"请输入地址" lastTime:1.5];
//        return;
//    }
//    if (StringIsNullOrEmpty(self.stallDescribeTF.text)) {
//        [YFEasyHUD showMsg:@"保存失败" details:@"请输入主营项目" lastTime:1.5];
//        return;
//    }
//    if (StringIsNullOrEmpty(self.stallNumberTF.text)) {
//        [YFEasyHUD showMsg:@"保存失败" details:@"请输入档口编号" lastTime:1.5];
//        return;
//    }
//    if (StringIsNullOrEmpty(self.stallNameTF.text)) {
//        [YFEasyHUD showMsg:@"保存失败" details:@"请输入档口名称" lastTime:1.5];
//        return;
//    }
//    if (StringIsNullOrEmpty(self.stallPhoneTF.text)) {
//        [YFEasyHUD showMsg:@"保存失败" details:@"请输入手机号码" lastTime:1.5];
//        return;
//    }
//
//    
//    Stall *stall = [Stall object];
//    stall.name = self.stallNameTF.text;
//    stall.number = @([self.stallNumberTF.text integerValue]);
//    stall.major_business = self.stallDescribeTF.text;
//    stall.address = self.stallAddressTF.text;
//    stall.restaurant = self.currentRestaurant;
//    stall.image_url = self.imageURL;
//    
//    NSError *error = nil;
//    [stall save:&error];
//    
//    if (error) {
//        return;
//    }
//    
    [self performSegueWithIdentifier:@"ADDSTALL2ADDFOOD" sender:nil];
}


#pragma mark -- Custom Delegate --

- (void)photoPickerSavedInDefaults:(UIImage *)selectedImage {
    AVFile *file = [AVFile fileWithData:self.photoPickerView.compressedData];
    
    IMP_BLOCK_SELF(MOAddStallController)
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            block_self.imageURL = file.url;
        }
    }];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destiVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"ADDSTALL2ADDFOOD"]) {
        [destiVC setStall:sender];
    }
}

@end
