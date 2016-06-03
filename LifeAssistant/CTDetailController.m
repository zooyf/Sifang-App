//
//  CTDetailController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/6/2.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "CTDetailController.h"
#import "Contact.h"

@interface CTDetailListCell : UITableViewCell {
    Contact *_contact;
}

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

/**
 *  联系人所属部门
 */
@property (nonatomic, strong) Department *detailDepartment;

/**
 *  联系人
 */
@property (nonatomic, strong) Contact *contact;

/**
 *  点击添加并成功时的回调,传入Contact实例
 */
@property (nonatomic, copy) void(^completionBlock)(id sender);

@end

@implementation CTDetailListCell
- (Contact *)contact {
    if (!_contact) {
        _contact = [Contact object];
    }
    return _contact;
}

- (void)setContact:(Contact *)contact {
    _contact = contact;
    
    self.nameTF.text = contact.name;
    self.phoneTF.text= S(@"%@", contact.phone ? : @"");
    
    [self setHiddenOfCancelBtn:YES editBtn:![AppConfig isManagerUser]];
}

- (void)awakeFromNib {
    [self.cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];

    self.addBtn.hidden = YES;
    [self setHiddenOfCancelBtn:true editBtn:![AppConfig isManagerUser]];
}

- (void)setHiddenOfCancelBtn:(BOOL)cancelHidden editBtn:(BOOL)editHidden {
    [self.contentView endEditing:cancelHidden];
    
    self.cancelBtn.hidden = cancelHidden;
    self.editBtn.hidden = editHidden;
    
    BOOL addBtnDisplaying = cancelHidden && editHidden;
    self.addBtn.hidden = [AppConfig isManagerUser] ? !addBtnDisplaying : YES;
    
    self.nameTF.enabled = (!cancelHidden || addBtnDisplaying) && [AppConfig isManagerUser];
    self.phoneTF.enabled = (!cancelHidden || addBtnDisplaying) && [AppConfig isManagerUser];
}

- (void)cancelAction:(id)sender {
//    [self setFood:self.food];
    
    [self setHiddenOfCancelBtn:YES editBtn:NO];
    
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn removeTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)editAction:(id)sender {
    
    [self setHiddenOfCancelBtn:NO editBtn:NO];
    
    [self.nameTF becomeFirstResponder];
    
    [self.editBtn setTitle:@"完成" forState:UIControlStateNormal];
    [sender removeTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)completeAction:(id)sender {
    
    if ([self verifyInputContents]) {
        [self setHiddenOfCancelBtn:YES editBtn:NO];
    }
    
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [sender removeTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(id)sender {
    [self.contentView endEditing:YES];
    
    if (![self verifyInputContents]) {
        return;
    }
    
    BlockCallWithOneArg(self.completionBlock, self.contact);
    
}

- (BOOL)verifyInputContents {
    [YFEasyHUD showIndicator];
    
    if (StringIsNullOrEmpty(self.nameTF.text)) {
        [YFEasyHUD showMsg:@"更新失败" details:@"您未输入名称" lastTime:1.5];
        [self.nameTF becomeFirstResponder];
        return NO;
    }
    if (StringIsNullOrEmpty(self.nameTF.text)) {
        [YFEasyHUD showMsg:@"更新失败" details:@"您未输入价格" lastTime:1.5];
        [self.phoneTF becomeFirstResponder];
        return NO;
    }
    
    
    self.contact.name = self.nameTF.text;
    self.contact.phone = self.phoneTF.text;
    self.contact.department = self.detailDepartment;
    
    [self.contentView endEditing:YES];
    
    NSError *error = nil;
    [self.contact save:&error];
    
    if (error) {
        [YFEasyHUD showMsg:@"更新失败" details:@"请检查网络" lastTime:1.5];
        return NO;
    }
    
    [YFEasyHUD hideHud];
    
    return YES;
    
}

@end


#pragma mark -------------------- CTDetailController implementation --------------------

@interface CTDetailController ()

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation CTDetailController
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestContacts];
    // Do any additional setup after loading the view.
}

- (void)requestContacts {
    AVQuery *query = [AVQuery queryWithClassName:[Contact parseClassName]];
    [query whereKey:@"department" equalTo:self.currentDepartment];
    
    IMP_BLOCK_SELF(CTDetailController)
    [YFEasyHUD showIndicator];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [YFEasyHUD hideHud];
        
        if (error) {
            [YFEasyHUD showMsg:@"请求失败" details:@"请检查网络" lastTime:2];
            return ;
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


#pragma mark -- UITableViewDelegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count + [AppConfig isManagerUser];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:@"CTDetailEditCell"];
    
    IMP_BLOCK_SELF(CTDetailController)
    // 最后一行 out of datalist
    if (self.dataList.count == indexPath.row) {
        [cell setDetailDepartment:self.currentDepartment];
        [cell setHiddenOfCancelBtn:YES editBtn:YES];
        
        [cell setCompletionBlock:^(id sender) {
            
            [block_self.dataList addObject:sender];
            [block_self.tableView reloadData];
        }];
    } else {
        [cell setContact:self.dataList[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Contact *contact = self.dataList[indexPath.row];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:nil];
    __weak typeof(contact) weakContact = contact;
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", weakContact.phone]]];
    }];
    UIAlertController *alertCall = [UIAlertController alertControllerWithTitle:@"拨打电话" message:S(@"是否给%@拨打电话?", contact.phone) preferredStyle:UIAlertControllerStyleAlert];
    [alertCall addAction:cancel];
    [alertCall addAction:confirm];
    
    [self presentViewController:alertCall animated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return !(self.dataList.count == indexPath.row);
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
