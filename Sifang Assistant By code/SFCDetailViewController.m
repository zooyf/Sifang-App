//
//  SFCDetailViewController.m
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/18.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import "SFCDetailViewController.h"

@interface SFCDetailViewController ()

- (void)save:(id)sender;

@end

@implementation SFCDetailViewController

- (void)save:(id)sender
{
    
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
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 10, 75, 25);
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 75, 25)];
    label.textAlignment = UITextAlignmentRight;
//    label.tag = klabel;
    label.font = [UIFont boldSystemFontOfSize:14];
    [cell.contentView addSubview:label];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 25)];
    field.clearsOnBeginEditing = NO;
    field.delegate = self;
    field.returnKeyType = UIReturnKeyDone;
    field.tag = indexPath.row;
//    [field addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];  //暂时不懂
    [cell.contentView addSubview:field];
    NSUInteger row = [indexPath row];
    //    UILabel *label = (UILabel *)[cell viewWithTag:klabel];
    
    label.text = self.labelArray[row];
    //UITextField *field = (UITextField *)[cell viewWithTag:row];
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return knumberofrow;
}

@end
