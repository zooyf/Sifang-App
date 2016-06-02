//
//  YFMineViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/20.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFContactViewController.h"
#import "CTDetailController.h"
#import "Department.h"
#import <MJRefresh/MJRefresh.h>

@interface CTDepartmentCell : UITableViewCell {
    Department *_department;
}

@property (weak, nonatomic) IBOutlet UITextField *departmentTF;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, strong) Department *department;
@property (nonatomic, copy) void(^completionBlock)(id sender);
@end

@implementation CTDepartmentCell
- (Department *)department {
    if (!_department) {
        _department = [Department object];
    }
    return _department;
}

- (void)setDepartment:(Department *)department {
    _department = department;
    
    self.departmentTF.text = department.name;
    
    self.editBtn.hidden = NO;
    self.addBtn.hidden = YES;
    [self setHiddenOfCancelBtn:YES];
}

- (void)awakeFromNib {
    self.cancelBtn.hidden = YES;
    self.editBtn.hidden = ![AppConfig isManagerUser];
    
    self.addBtn.hidden = [AppConfig isManagerUser] ? !self.editBtn.hidden : YES;
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setHiddenOfCancelBtn:(BOOL)cancelHidden editBtn:(BOOL)editHidden {
    self.cancelBtn.hidden = cancelHidden;
    self.editBtn.hidden = editHidden;
    self.addBtn.hidden = NO;
    
    self.departmentTF.enabled = YES;
}

- (void)setHiddenOfCancelBtn:(BOOL)cancelHidden {
    [self.contentView endEditing:cancelHidden];
    
    self.cancelBtn.hidden = cancelHidden;
    
    self.departmentTF.enabled = !cancelHidden;
}

- (void)cancelAction:(id)sender {
    [self setDepartment:self.department];
    
    [self setHiddenOfCancelBtn:YES];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn removeTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)editAction:(id)sender {
    
    [self setHiddenOfCancelBtn:NO];
    
    [self.departmentTF becomeFirstResponder];
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sender removeTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)completeAction:(id)sender {
    
    if ([self verifyInputContents]) {
        [self setHiddenOfCancelBtn:YES];
    }
    if (![sender isKindOfClass:[UIButton class]]) {
        return;
    }
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [sender removeTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(id)sender {
    
    if (![self verifyInputContents]) {
        return;
    }
    BlockCallWithOneArg(self.completionBlock, self.department);
    [self.contentView endEditing:YES];
}

- (BOOL)verifyInputContents {
    [YFEasyHUD showIndicator];
    
    if (StringIsNullOrEmpty(self.departmentTF.text)) {
        [YFEasyHUD showMsg:@"更新失败" details:@"您未输入名称" lastTime:1.5];
        [self.departmentTF becomeFirstResponder];
        return NO;
    }
    
    [self.contentView endEditing:YES];
    
    Department *department = self.department;
    department.name = self.departmentTF.text;
    NSError *error = nil;
    [department save:&error];
    
    if (error) {
        [YFEasyHUD showMsg:@"更新失败" details:@"请检查网络" lastTime:1.5];
        return NO;
    }
    
    [YFEasyHUD hideHud];
    
    return YES;
    
}

@end

#pragma mark -- YFContactViewController implementation --

@interface YFContactViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation YFContactViewController
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[].mutableCopy;
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self requestData];
    
    // Do any additional setup after loading the view.
}

- (void)requestData {
    NSString *depstr = [Department parseClassName];
    NSLog(@"%@", depstr);
    AVQuery *query = [AVQuery queryWithClassName:[Department parseClassName]];
    [YFEasyHUD showIndicator];
    IMP_BLOCK_SELF(YFContactViewController)
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [YFEasyHUD hideHud];
        
        if (error) {
            [YFEasyHUD showMsg:@"请求失败" details:@"请检查网络" lastTime:2];
        }
        
        if (objects && objects.count) {
            [block_self.dataList addObjectsFromArray:objects];
            [block_self.tableView reloadData];
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:@"CTDEPARTMENTCELL"];
    
    IMP_BLOCK_SELF(YFContactViewController)
    // last cell out of datalist
    if (self.dataList.count == indexPath.row) {
        [cell setHiddenOfCancelBtn:YES editBtn:YES];
        
        [cell setCompletionBlock:^(id sender) {
            [block_self.dataList addObject:sender];
            [block_self.tableView reloadData];
        }];
    } else {
//        cell.food.stall = self.stall;
        [cell setDepartment:self.dataList[indexPath.row]];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // 最后一行返回NO 不允许点击
    return self.dataList.count == indexPath.row ? NO : YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count + [AppConfig isManagerUser];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destinationController = segue.destinationViewController;
    
    [destinationController setHidesBottomBarWhenPushed:YES];
    
    if ([segue.identifier isEqualToString:kSegueCONTACT2DETAIL]) {
        [destinationController setCurrentDepartment:(Department *)[sender department]];
    }
}

@end
