//
//  YFMineInfoViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/6/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "MYInfoController.h"

@interface MYInfoController ()
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *gradeTF;
@property (weak, nonatomic) IBOutlet UITextField *departmentTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *qqTF;

- (IBAction)logoutAction:(id)sender;

@property (nonatomic, strong) AVUser *currentUser;

@end

@implementation MYInfoController
- (AVUser *)currentUser {
    return [AVUser currentUser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.logoutBtn.layer.cornerRadius = CGRectGetHeight(self.logoutBtn.frame)/2.0;
    
    self.footerView.frame = CGRectMake(0, 0, ScreenWidth, 100);
    self.tableView.tableFooterView = self.footerView;
    
    self.selEditAction = @selector(editInfoAction:);
    
    [self textFieldsChangEnable:NO];
    // Do any additional setup after loading the view.
}

- (void)editInfoAction:(UIBarButtonItem *)item {
    [self textFieldsChangEnable:YES];
    [item setAction:@selector(doneEditAction:)];
    [self.nameTF becomeFirstResponder];
    [item setTitle:@"完成"];
}

- (void)doneEditAction:(UIBarButtonItem *)item {
    [self.view endEditing:YES];
    [self textFieldsChangEnable:NO];
    [item setAction:@selector(editInfoAction:)];
    [item setTitle:@"编辑"];
}

- (void)textFieldsChangEnable:(BOOL)enable {
    self.qqTF.enabled = enable;
    self.nameTF.enabled = enable;
    self.gradeTF.enabled = enable;
    self.phoneTF.enabled = enable;
    self.departmentTF.enabled = enable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- UITableViewDelegate --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
    [AVUser logOut];
    BlockCallWithVoidArg(self.logoutBlock);
}

@end
