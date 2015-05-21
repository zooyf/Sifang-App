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
        [self.tempValue setObject:self.textFields.text forKey:(NSString*)rowNum.stringValue];    //根据标签提取对象，然后根据将该数字对象设为该文字段的键
    }
    
    //根据键将self.tempValue复制到self.courseInfo数据类中。
    for(NSString *key in [self.tempValue allKeys])
    {
        switch ([key intValue]) {
            default:
                break;
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
        }
    }
    
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"test.plist"];
    NSLog(@"self.temValue:%@",self.tempValue);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.allKeys];
    NSLog(@"dict:%@",dict);
    
    [dict setObject:self.tempValue forKey:self.courseInfo.indexPath];
    //输入写入
    [dict writeToFile:filename atomically:YES];
    dict = nil;

    dict = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"dict:%@",dict);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    NSArray *array = [[NSArray alloc] initWithObjects:@"第一节：",@"第二节：",@"第三节：",@"第四节：" ,nil];
    self.labelArray = array;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;

    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"test.plist"];
    NSFileManager* fm = [NSFileManager defaultManager];
//    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
////删除文件
//    [fm removeItemAtPath:filename error:nil];
    BOOL isDirExist = [fm fileExistsAtPath:filename];
    //创建文件
    if (!isDirExist) {
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    self.allKeys = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    if (self.allKeys==nil) {
        self.allKeys = [[NSMutableDictionary alloc] init];
    }
    self.tempValue = [self.allKeys objectForKey:self.courseInfo.indexPath];
    if (self.tempValue==nil) {
        self.tempValue = [[NSMutableDictionary alloc] init];
    }
    NSLog(@"allkeys:%@\ntempValue:%@",self.allKeys,self.tempValue);
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
//    if (self.allKeys) {
        NSNumber *rownNumber = [[NSNumber alloc] initWithInt:row];
        NSString *rownNum = (NSString*)rownNumber.stringValue;
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
        
//    }
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
    [self.tempValue setObject:textField.text forKey:(NSString*)rowNum.stringValue];

}
@end
