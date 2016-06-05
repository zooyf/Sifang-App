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
#import "UIPlaceholderTextView.h"
#import <UIImageView+WebCache.h>

#pragma mark -- FMDistributeViewController --

@interface FMDistributeViewController ()<YFPhotoPickerViewDelegate> {
    Product *_product;
}

@property (nonatomic, strong) NSString          *imageURL;
@property (nonatomic, strong) YFPhotoPickerView *photoPickerView;
@property (nonatomic, strong) SinglePickerView  *sView;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *describeTF;
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *qqTF;
@property (weak, nonatomic) IBOutlet UITextField *kindTF;

@end

@implementation FMDistributeViewController
- (Product *)product {
    if (!_product) {
        _product = [Product object];
    }
    return _product;
}

- (void)setProduct:(Product *)product {
    _product = product;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTF.text = self.product.title;
    self.priceTF.text = self.product.price;
    self.locationTF.text = self.product.deal_location;
    self.phoneTF.text = self.product.phone_num;
    self.qqTF.text = self.product.qq;
    self.imageURL = self.product.imageUrl;
    if (self.product.title) {
        self.kindTF.text = [AppConfig allKind][self.product.kind.integerValue];
        self.describeTF.text = self.product.describe;
    } else {
        [self.describeTF setPlaceholder:@"请输入商品描述"];
    }
    
    IMP_BLOCK_SELF(FMDistributeViewController)
    // 键盘出现表格移动动画
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        id _obj = [note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect _keyboardFrame = CGRectNull;
        if ([_obj respondsToSelector:@selector(getValue:)]) [_obj getValue:&_keyboardFrame];
        [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [block_self.tableView setContentInset:UIEdgeInsetsMake(0.f, 0.f, _keyboardFrame.size.height+10, 0.f)];
        } completion:nil];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [UIView animateWithDuration:0.25f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [block_self.tableView setContentInset:UIEdgeInsetsZero];
        } completion:nil];
    }];
    
    // 添加图片视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.tableView.frame), CGRectGetMinY(self.tableView.frame), ScreenWidth, ScreenWidth/3.0)];
    CGFloat pickerViewBorder = headerView.frame.size.height * 0.8;
    self.photoPickerView = [[YFPhotoPickerView alloc] initWithFrame:CGRectMake(0, 0, pickerViewBorder, pickerViewBorder)];
    [self.photoPickerView sd_setImageWithURL:URL(self.product.imageUrl) placeholderImage:[UIImage imageNamed:@"take_photo"]];
    self.photoPickerView.center = headerView.center;
    [headerView addSubview:self.photoPickerView];
    
    self.tableView.tableHeaderView = headerView;
    
    self.photoPickerView = headerView.subviews.firstObject;
    self.photoPickerView.delegate = self;
    
    
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(distributeAction:)];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cancelAction:(id)sender {
    [self.view endEditing:YES];
    
    IMP_BLOCK_SELF(FMDistributeViewController)
    UIAlertController *cancelAlert = [UIAlertController alertControllerWithTitle:@"放弃发布商品"
                                                                         message:@"填写的信息将不会被保存"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *abortAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [block_self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"继续发布" style:UIAlertActionStyleCancel handler:nil];
    
    [cancelAlert addAction:abortAction];
    [cancelAlert addAction:continueAction];
    
    [self presentViewController:cancelAlert animated:YES completion:nil];
}

- (void)distributeAction:(id)sender {
    [self.view endEditing:YES];
    
    if (!self.imageURL) {
        [YFEasyHUD showMsg:@"请选择图片" details:nil lastTime:1.5];
        return;
    }

    for (int i = 0; i < [self.tableView numberOfRowsInSection:0]; i++) {
        id cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        for (id view in [cell contentView].subviews) {
            if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]]) {
                
                if (StringIsNullOrEmpty([view text])) {
                    [YFEasyHUD showMsg:S(@"请输入%@", [view placeholder]) details:nil lastTime:2];
                    return;
                }
            }
        }
    }
    
    [YFEasyHUD showMsg:@"发布中..."];
    
    Product *pro = self.product;
    pro.title           = self.nameTF.text;
    pro.price           = self.priceTF.text;
    pro.describe        = self.describeTF.text;
    pro.deal_location   = self.locationTF.text;
    pro.phone_num       = self.phoneTF.text;
    pro.qq              = self.qqTF.text;
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
        
        [YFEasyHUD showMsg:@"发布成功" details:nil lastTime:2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [block_self.navigationController popViewControllerAnimated:YES];
        });
    }];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IMP_BLOCK_SELF(FMDistributeViewController)
    
    // 分类选择器
    if (indexPath.row == 6) {
        
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
            block_self.kindTF.text = kind.name;
            block_self.product.kind = @(kind.code+1);
            [block_self.sView closeAction];
        };
        [self.sView show];
    }

}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
