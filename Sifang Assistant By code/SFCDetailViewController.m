//
//  SFCDetailViewController.m
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/18.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import "SFCDetailViewController.h"
#import "AppDelegate.h"
@interface SFCDetailViewController ()<UITextFieldDelegate>

- (void)save:(id)sender;

@end

@implementation SFCDetailViewController

- (void)save:(id)sender
{
    if(self.textFields!=nil)
    {
        NSNumber *rowNum = [[NSNumber alloc] initWithInt:self.textFields.tag];
        [self.tempValue setObject:self.textFields.text forKey:rowNum];    //根据标签提取对象，然后根据将该数字对象设为该文字段的键
    }
    //根据键将self.tempValue复制到self.courseInfo数据类中。
    for(NSString *key in [self.tempValue allKeys])
    {
        switch ([key intValue]) {
            case kmoreing:
                self.courseInfo.morening = [self.tempValue objectForKey:key];
                break;
            case knoon:
                self.courseInfo.noon = [self.tempValue objectForKey:key];
                break;
            case kafternoon:
                self.courseInfo.afternoon = [self.tempValue objectForKey:key];
                break;
            case kevening:
                self.courseInfo.evening = [self.tempValue objectForKey:key];
                break;
                
            default:
                break;
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    NSArray *array = [[NSArray alloc] initWithObjects:@"上午：",@"中午：",@"下午：",@"晚上：" ,nil];
    self.labelArray = array;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.tempValue = dic;
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 10, 75, 25);
    label.textAlignment = UITextAlignmentRight;
    label.tag = klabel;
    label.font = [UIFont boldSystemFontOfSize:14];
    [cell.contentView addSubview:label];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 25)];
    field.clearsOnBeginEditing = NO;
    field.delegate = self;
    field.returnKeyType = UIReturnKeyDone;
    [cell.contentView addSubview:field];
    
    NSUInteger row = [indexPath row];
    
//    label.text = self.labelArray[row];
    label.text = [self.labelArray objectAtIndex:row];
    field = nil;
    for(UIView *view in cell.contentView.subviews)
    {
        if([view isMemberOfClass:[UITextField class]])
            field = (UITextField *)view;
    }
    NSNumber *rownNum = [[NSNumber alloc] initWithInt:row];
    
    switch (row) {
        case kmoreing:
            if([[self.tempValue allKeys]containsObject:rownNum])
                field.text = [self.tempValue objectForKey:rownNum];
            else
                field.text = self.courseInfo.morening;
            break;
        case knoon:
            if([[self.tempValue allKeys]containsObject:rownNum])
                field.text = [self.tempValue objectForKey:rownNum];
            else
                field.text = self.courseInfo.noon ;
            break;
        case kafternoon:
            if([[self.tempValue allKeys] containsObject:rownNum ])
                field.text = [self.tempValue objectForKey:rownNum];
            else
                field.text = self.courseInfo.afternoon;
            break;
        case kevening:
            if([[self.tempValue allKeys] containsObject:rownNum])
                field.text = [self.tempValue objectForKey:rownNum];
            else
                field.text = self.courseInfo.evening;
            break;
            
        default:
            break;
    }
    field.tag =row;
    if(self.textFields == field)
        self.textFields =nil;
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return knumberofrow;
}

//按下文字段时调用的方法，将textField指针指向文字段
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.textFields = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSNumber *rowNum = [[NSNumber alloc] initWithInt:textField.tag];
    [self.tempValue setObject:textField.text forKey:rowNum];
}
@end
