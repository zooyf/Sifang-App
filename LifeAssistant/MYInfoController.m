//
//  YFMineInfoViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/6/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "MYInfoController.h"
#import "YFPhotoPickerView.h"

@interface MYInfoController ()<YFPhotoPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet YFPhotoPickerView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *gradeTF;
@property (weak, nonatomic) IBOutlet UITextField *departmentTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *qqTF;

- (IBAction)logoutAction:(id)sender;

@property (nonatomic, strong) UIImage *avatarImage;
@property (nonatomic, strong) AVFile *avatarFile;
@property (nonatomic, strong) AVUser *currentUser;

@end

@implementation MYInfoController
- (AVFile *)avatarFile {
    return [AVUser currentUser].avatar;
}

- (AVUser *)currentUser {
    return [AVUser currentUser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logoutBtn.layer.cornerRadius = CGRectGetHeight(self.logoutBtn.frame)/2.0;
    
    self.footerView.frame = CGRectMake(0, 0, ScreenWidth, 100);
    self.tableView.tableFooterView = self.footerView;
    
    self.selEditAction = @selector(editInfoAction:);
    
    self.avatarImageView.delegate = self;
    self.avatarImageView.allowsEditing = YES;
    if (self.afterReg) {
        [self textFieldsChangToEnableEditing:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        [self.logoutBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.avatarImageView.userInteractionEnabled = YES;
        [self.nameTF becomeFirstResponder];
        return;
    }
    self.avatarImageView.userInteractionEnabled = NO;
    
    [self textFieldsChangToEnableEditing:self.afterReg];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.avatarImage) {
        UIImage *image = [UIImage imageWithData:self.avatarFile.getData];
        self.avatarImage = image ? :[UIImage imageNamed:@"placeholder_avatar"];
    }
    self.avatarImageView.image = self.avatarImage;

    AVUser *currentUser = self.currentUser;
    self.nameTF.text = currentUser.name;
    self.phoneTF.text = currentUser.mobilePhoneNumber;
    self.gradeTF.text = currentUser.grade;
    self.departmentTF.text = currentUser.department;
    self.qqTF.text = currentUser.qqNumber;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editInfoAction:(UIBarButtonItem *)item {
    [self.navigationController pushViewController:[YFUtils infoController] animated:YES];
    
//    self.avatarImageView.userInteractionEnabled = YES;
//    [self textFieldsChangToEnableEditing:YES];
//    [item setAction:@selector(doneEditAction:)];
//    [self.nameTF becomeFirstResponder];
//    [item setTitle:@"完成"];
}

- (void)doneEditAction:(UIBarButtonItem *)item {
    BOOL succeed = [self saveCurrentUser];
    
    if (succeed) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:NO];
        });
    }
    
    self.avatarImageView.userInteractionEnabled = NO;
    [self.view endEditing:YES];
    [self textFieldsChangToEnableEditing:NO];
    [item setAction:@selector(editInfoAction:)];
    [item setTitle:@"编辑"];
}

- (void)textFieldsChangToEnableEditing:(BOOL)enable {
    self.qqTF.enabled = enable;
    self.nameTF.enabled = enable;
    self.gradeTF.enabled = enable;
    self.phoneTF.enabled = enable;
    self.departmentTF.enabled = enable;
    self.qqTF.placeholder = enable ? @"可选" : @"暂无";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDelegate --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.afterReg ? 1 : 2;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)logoutAction:(id)sender {
    //完善信息
    if (self.afterReg) {
        BOOL succeed = [self saveCurrentUser];
        
        if (succeed) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:NO];
            });
        }
        
        return;
    }
    
    //退出
    [AVUser logOut];
    
    BlockCallWithVoidArg(self.logoutBlock);
}

- (BOOL)saveCurrentUser {
    
    if (StringIsNullOrEmpty(self.departmentTF.text)) {
        [YFEasyHUD showMsg:self.departmentTF.placeholder details:nil lastTime:2];
        return NO;
    }
    if (StringIsNullOrEmpty(self.gradeTF.text)) {
        [YFEasyHUD showMsg:self.gradeTF.placeholder details:nil lastTime:2];
        return NO;
    }
    if (StringIsNullOrEmpty(self.phoneTF.text)) {
        [YFEasyHUD showMsg:self.phoneTF.placeholder details:nil lastTime:2];
        return NO;
    }
    if (StringIsNullOrEmpty(self.nameTF.text)) {
        [YFEasyHUD showMsg:self.nameTF.placeholder details:nil lastTime:2];
        return NO;
    }
    
    [YFEasyHUD showIndicator];
    
    AVUser *currentUser = self.currentUser;
    currentUser.name = self.nameTF.text;
    currentUser.mobilePhoneNumber = self.phoneTF.text;
    currentUser.grade = self.gradeTF.text;
    currentUser.qqNumber = self.qqTF.text;
    currentUser.department = self.departmentTF.text;
    currentUser.avatar = self.avatarFile;
    
    [YFEasyHUD showIndicator];
    
    NSError *error = nil;
    [currentUser save:&error];
    
    [YFEasyHUD hideHud];
    if (!error) {
        [YFEasyHUD showMsg:@"保存成功" details:nil lastTime:1.5];
        return YES;
    } else {
        [YFEasyHUD showMsg:@"保存失败" details:@"请重试" lastTime:1.5];
        return NO;
    }
    
}

- (void)photoPickerSavedInDefaults:(UIImage *)selectedImage {
    
    UIImage *scaledImage = [selectedImage scaleToSize:CGSizeMake(500, 500)];
    AVFile *avatarFile = [AVFile fileWithData:UIImagePNGRepresentation(scaledImage)];
    [YFEasyHUD showMsg:@"正在上传,请等待..."];
    
    [self.avatarImageView setImage:scaledImage];
    self.avatarImage = scaledImage;
    
    [avatarFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [YFEasyHUD showMsg:@"头像上传成功" details:nil lastTime:1.5];
            self.avatarFile = avatarFile;
            return;
        }
        
        [YFEasyHUD showMsg:@"头像上传失败" details:@"请重试" lastTime:2];
        
    }];

}

@end
