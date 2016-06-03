//
//  FMDistributeViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "FMDistributeViewController.h"
#import "YFPhotoPickerView.h"
#import "Product.h"
#import "SinglePickerView.h"

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

@interface FMDistributeViewController ()<UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, YFPhotoPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray    *titleArr;
@property (nonatomic, strong) NSString          *imageURL;
@property (nonatomic, strong) YFPhotoPickerView *photoPickerView;
@property (nonatomic, strong) SinglePickerView  *sView;
@property (nonatomic, strong) Product           *product;

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

NSString * const kPickerName     = @"pickerView";

- (Product *)product {
    if (!_product) {
        _product = [Product object];
    }
    return _product;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 键盘出现表格移动动画
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        id _obj = [note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect _keyboardFrame = CGRectNull;
        if ([_obj respondsToSelector:@selector(getValue:)]) [_obj getValue:&_keyboardFrame];
        [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_tableView setContentInset:UIEdgeInsetsMake(0.f, 0.f, _keyboardFrame.size.height+10, 0.f)];
        } completion:nil];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_tableView setContentInset:UIEdgeInsetsZero];
        } completion:nil];
    }];
    
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
    
    if (!self.imageURL) {
        [YFEasyHUD showMsg:@"请选择图片" details:nil lastTime:1.5];
        return;
    }

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.titleArr.count];
    for (int i = 0; i < self.titleArr.count; i++) {
        id cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        NSString *inputStr = nil;
        if ([cell respondsToSelector:@selector(textView)]) {
            inputStr = [cell textView].text;
        } else if ([cell respondsToSelector:@selector(textField)]) {
            inputStr = [cell textField].text;
        } else {
            
        }
        
        if (StringIsNullOrEmpty(inputStr)) {
            NSString *title = [cell titleLabel].text;
            [YFEasyHUD showMsg:S(@"请输入%@", title) details:nil lastTime:1.5];
            return;
        }
        
        [array addObject:inputStr];
    }
    
    [YFEasyHUD showMsg:@"发布中..."];
    
    Product *pro = self.product;
    pro.title           = array[0];
    pro.price           = array[1];
    pro.describe        = array[2];
    pro.deal_location   = array[3];
    pro.phone_num       = array[4];
    pro.qq              = array[5];
    pro.imageUrl        = self.imageURL;
    pro.seller = [AVUser currentUser];
    
    pro.saleStatus = [NSNumber numberWithInt:ProductStatusOnSale];
    
    IMP_BLOCK_SELF(FMDistributeViewController)
    [pro saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            [YFEasyHUD showMsg:@"发布失败" details:@"请重试" lastTime:1.5];
            return ;
        }
        
        [YFEasyHUD hideHud];
        
        [block_self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

- (IBAction)tapToEndEditing:(id)sender {
    [self.view endEditing:YES];
}

- (void)photoPickerSavedInDefaults:(UIImage *)selectedImage {
    AVFile *file = [AVFile fileWithData:self.photoPickerView.compressedData];
    
    IMP_BLOCK_SELF(FMDistributeViewController)
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            block_self.imageURL = file.url;
        }
    }];
}

#pragma mark -- UITableViewDelegate & UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *text = self.titleArr[indexPath.row];
    
    // picker cell
    if ([text isEqualToString:kPickerName]) {
        id cell = [tableView dequeueReusableCellWithIdentifier:@"FMDistributePickerCell"];        
        return cell;
    }
    
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
    [self.view endEditing:YES];
    
    IMP_BLOCK_SELF(FMDistributeViewController)
    
    // 分类选择器
    if ([self.titleArr[indexPath.row] isEqualToString:kKindName]) {
        
        id cell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSArray *allKindArray = [AppConfig allKind];
        NSMutableArray *aryItems = [NSMutableArray arrayWithCapacity:allKindArray.count];
        for (int i = 0; i < allKindArray.count; i++) {
            
            
            [aryItems addObject:[ChooseItem itemWithCode:i name:allKindArray[i]]];
        }
        
        if(!self.sView)
        {
            self.sView = [[SinglePickerView alloc] init];
        }
        self.sView.aryItems = aryItems;
        self.sView.title = @"请选择分类";
        self.sView.sureHandler = ^(ChooseItem * kind)
        {
            @try {
                [cell textField].text = kind.name;
            } @catch (NSException *exception) {
                [cell textView].text = kind.name;
            } @finally {
                block_self.product.kind = @(kind.code+1);
            }
            [block_self.sView closeAction];
        };
        [self.sView show];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.titleArr[indexPath.row] isEqualToString:kPickerName]) {
        return 100;
    }
    return 60;
}


#pragma mark -- UIPickerViewDataSource & UIPickerViewDelegate --

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 12;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"hhh";
}


#pragma mark -- Lazily --

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[
                      kProductName,
                      kPriceName,
                      kDescName,
                      kPlaceName,
                      kPhoneNumber,
                      kQQNumber,
                      kKindName
                      ].mutableCopy;
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
