//
//  SinglePickerView.m
//  BossZP
//
//  Created by yuyang on 15/8/31.
//  Copyright (c) 2015年 com.dlnu.*. All rights reserved.
//

#import "SinglePickerView.h"

#define Tools_height  45.f
#define btn_width     50.f
#define picker_height 162.f

@interface SinglePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIPickerView * picker;     //
@property (nonatomic,strong) UIView *       bgView;     //工具条
@property (nonatomic,strong) UIView *       line;       //线
@property (nonatomic,strong) UIButton *     btnCancel;  //取消
@property (nonatomic,strong) UIButton *     btnSure;    //确定
@property (nonatomic,strong) UILabel *      lbTitle;    //标题

@property (nonatomic,strong) ChooseItem *   selectItem;

@end

@implementation SinglePickerView

-(id)init
{
    if(self = [super init])
    {
        self.frame = [UIScreen mainScreen].bounds;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        UIButton * btnRemove = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRemove.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [btnRemove addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnRemove];
        
        //pickerview
        self.picker = [[UIPickerView alloc] init];
        self.picker.backgroundColor = [UIColor whiteColor];
        self.picker.frame = CGRectMake(0, ScreenHeight - picker_height, ScreenWidth, picker_height);
        self.picker.showsSelectionIndicator=YES;
        [self addSubview:self.picker];
        //按钮s
        self.bgView = [[UIView alloc] init];
        self.bgView.frame = CGRectMake(0, ScreenHeight - Tools_height - picker_height, ScreenWidth, Tools_height);
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.bgView.userInteractionEnabled = YES;
        [self addSubview:self.bgView];
        
        self.line = [[UIView alloc] init];
        self.line.frame = CGRectMake(0, Tools_height - 0.5, ScreenWidth, 0.5);
        self.line.backgroundColor = [UIColor lightGrayColor];
        [self.bgView addSubview:self.line];
        
        self.btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnCancel.frame = CGRectMake(0, 0, btn_width, Tools_height);
        [self.btnCancel setImage:IMG(@"picker_cancel_red.png") forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:[UIColor colorWithHexString:@"797979"] forState:UIControlStateNormal];
        [self.btnCancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:self.btnCancel];
        
        self.btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSure.frame = CGRectMake(ScreenWidth - btn_width, 0, btn_width, Tools_height);
        [self.btnSure setImage:IMG(@"picker_ok_red.png") forState:UIControlStateNormal];
        [self.btnSure setTitleColor:[UIColor colorWithHexString:@"797979"] forState:UIControlStateNormal];
        [self.btnSure addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:self.btnSure];
        
        self.lbTitle = [[UILabel alloc] init];
        self.lbTitle.frame = CGRectMake(btn_width, 0, ScreenWidth - 2 * btn_width, Tools_height);
        self.lbTitle.font = [UIFont CustomFontGBKSize:15];
        self.lbTitle.textAlignment = NSTextAlignmentCenter;
        self.lbTitle.textColor = [UIColor colorWithHexString:@"797979"];
        [self.bgView addSubview:self.lbTitle];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.lbTitle.text = title;
}

- (void)setAryItems:(NSArray *)aryItems
{
    _aryItems = aryItems;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
}

- (void)cancelAction
{
    BlockCallWithOneArg(self.cancelHandler, nil);
    [self closeAction];
}

- (void)sureAction
{
    BlockCallWithOneArg(self.sureHandler, self.selectItem?:self.aryItems.firstObject);
}

- (void)closeAction
{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.picker.originY = ScreenHeight;
        self.bgView.originY = ScreenHeight;
    } completion:^(BOOL finished) {
        self.picker.delegate = nil;
        self.picker.dataSource = nil;
        [self removeFromSuperview];
    }];
}

- (void)show
{
    self.picker.delegate = self;
    self.picker.dataSource = self;
    if(self.selectedIndex < self.aryItems.count)
    {
        self.selectItem = [self.aryItems objectAtIndex:self.selectedIndex];
        [self.picker selectRow:self.selectedIndex inComponent:0 animated:NO];
    }
    [self.picker reloadAllComponents];
    [theApp.window addSubview:self];
    self.alpha = 0;
    self.bgView.originY = ScreenHeight;
    self.picker.originY = ScreenHeight + Tools_height;
    IMP_BLOCK_SELF(SinglePickerView);
    [UIView animateWithDuration:0.3 animations:^{
        block_self.alpha = 1;
        block_self.picker.originY = ScreenHeight - picker_height;
        block_self.bgView.originY = ScreenHeight - Tools_height - picker_height;
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.aryItems.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(self.aryItems.count > 0)
    {
        if(row < self.aryItems.count)
        {
            ChooseItem * item = [self.aryItems objectAtIndex:row];
            return item.name;
        }
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(self.aryItems.count > 0)
    {
        if(row < self.aryItems.count)
        {
            self.selectItem = [self.aryItems objectAtIndex:row];
        }
    }
}

-(void)dealloc
{
    self.picker.delegate = nil;
    self.picker.dataSource = nil;
}

@end
