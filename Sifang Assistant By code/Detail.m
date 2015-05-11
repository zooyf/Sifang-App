//
//  Detail.m
//  课程表
//
//  Created by 雨 on 12-11-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Detail.h"
#import "ClassFIeld.h"
#import "AppDelegate.h"

@implementation Detail

@synthesize classField;
@synthesize tempValue;
@synthesize fieldLabel;
@synthesize textFields;


- (IBAction)cancel:(id)sender
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    if(textFields!=nil)
    {
        NSNumber *rowNum = [[NSNumber alloc] initWithInt:textFields.tag];
        [tempValue setObject:textFields.text forKey:rowNum];    //根据标签提取对象，然后根据将该数字对象设为该文字段的键
        [rowNum release];
    }
    //根据键将tempValue复制到ClassField数据类中。
    for(NSString *key in [tempValue allKeys])
    {
        switch ([key intValue]) {
            case kmoreing:
                classField.moreing = [tempValue objectForKey:key];
                break;
            case knoon:
                classField.noon = [tempValue objectForKey:key];
                break;
            case kafternoon:
                classField.afternoon = [tempValue objectForKey:key];
                break;
            case kevening:
                classField.evening = [tempValue objectForKey:key];
                break;
                
            default:
                break;
        }
    }
    //创建程序委托 ，将类加入导航控制器
    AppDelegate *delegate = [[UIApplication sharedApplication ]delegate];
    UINavigationController *nav = [delegate navController];
    [nav popViewControllerAnimated:YES];
    
    
    NSArray *all = nav.viewControllers;
    UITableViewController *parent = [all lastObject];
    [parent.tableView reloadData];
}

- (IBAction)textFieldDone:(id)sender
{
    [sender resignFirstResponder];
}

#pragma mark -
- (void)viewDidLoad
{
    NSArray *array = [[NSArray alloc] initWithObjects:@"上午：",@"中午：",@"下午：",@"晚上：" ,nil];
    self.fieldLabel = array;
    [array release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.tempValue = dic;
    [dic release];
    [super viewDidLoad];
    
    
}


- (void) dealloc
{
    [classField release];
    [textFields release];
    [tempValue release];
    [fieldLabel release];
    [super dealloc];
}


#pragma mark -
#pragma TableView Data Source Methods 
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return knumberofrow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 75, 25)];
        label.textAlignment = UITextAlignmentRight;
        label.tag = klabel;
        label.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:label];
        [label release];
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 25)];
        field.clearsOnBeginEditing = NO;
        field.delegate = self;
        field.returnKeyType = UIReturnKeyDone;
        field.tag = indexPath.row;
        [field addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];  //暂时不懂
        [cell.contentView addSubview:field];
        [field release];
    }
    NSUInteger row = [indexPath row];
    UILabel *label = (UILabel *)[cell viewWithTag:klabel];
    label.text = [fieldLabel objectAtIndex:row];
    //UITextField *field = (UITextField *)[cell viewWithTag:row];
    UITextField *field = nil;
    for(UIView *view in cell.contentView.subviews)
    {
        if([view isMemberOfClass:[UITextField class]])
            field = (UITextField *)view;
    }
    NSNumber *rownNum = [[NSNumber alloc] initWithInt:row];
    
    switch (row) {
        case kmoreing:
            if([[tempValue allKeys]containsObject:rownNum])
                field.text = [tempValue objectForKey:rownNum];
            else
                field.text = classField.moreing;
            break;
        case knoon:
            if([[tempValue allKeys]containsObject:rownNum])
                field.text = [tempValue objectForKey:rownNum];
            else
               field.text = classField.noon ;
            break;
        case kafternoon:
            if([[tempValue allKeys] containsObject:rownNum ])
                field.text = [tempValue objectForKey:rownNum];
            else
                field.text = classField.afternoon;
            break;
        case kevening:
            if([[tempValue allKeys] containsObject:rownNum])
                field.text = [tempValue objectForKey:rownNum];
            else
                field.text = classField.evening;
            break;
            
        default:
            break;
    }
    field.tag =row;
    if(textFields == field)
        textFields =nil;
    [rownNum release];
    return cell;
    
}




#pragma mark -
#pragma mark Table Delegate Methods
//按下文字段时调用的方法，将textField指针指向文字段
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.textFields = textField;
}

//按下return键调用的方法，将文字段储存在tempvalue中
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSNumber *rowNum = [[NSNumber alloc] initWithInt:textField.tag];
    [tempValue setObject:textField.text forKey:rowNum];
    [rowNum release];
}
//演示


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tempValue=nil;
    self.textFields = nil;
    self.classField = nil;
    self.fieldLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
