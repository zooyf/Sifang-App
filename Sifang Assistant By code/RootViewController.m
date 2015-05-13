//
//  RootViewController.m
//  课程表
//
//  Created by 雨 on 12-11-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "ClassFIeld.h"
#import "Detail.h"
#import "AppDelegate.h"

@implementation RootViewController
@synthesize controllers;


//载入视图
- (void) viewDidLoad
{
    [super viewDidLoad];
    self.title = @"课程表";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    ClassFIeld *monday = [[ClassFIeld alloc] init];
    monday.title =@"Monday";
    [array addObject:monday];
    [monday release];
    
    ClassFIeld *tuesday = [[ClassFIeld alloc] init];
    tuesday.title = @"Tuesday";
    [array addObject:tuesday];
    [tuesday release];
    
    ClassFIeld *wednesday = [[ClassFIeld alloc] init];
    wednesday.title = @"Wednesday";
    [array addObject:wednesday];
    [wednesday release];
    
    ClassFIeld *thursday=[[ClassFIeld alloc] init];
    thursday.title = @"Thursday";
    [array addObject:thursday];
    [thursday release];
    
    ClassFIeld *friday = [[ClassFIeld alloc] init];
    friday.title =@"Friday";
    [array addObject:friday];
    [friday release];
    
    ClassFIeld *saturday = [[ClassFIeld alloc] init];
    saturday.title = @"Saturday";
    [array addObject:saturday];
    [saturday release];
    
    ClassFIeld *sunday = [[ClassFIeld alloc] init];
    sunday.title = @"Sunday";
    [array addObject:sunday];
    [sunday release];
    
    self.controllers = array ;
    
    [array release];
}


#pragma mark -
#pragma  mark Table Data Source Methods

//返回表视图对象的行数，每个对象对应一行
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RootViewControllerCell =@"RootViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RootViewControllerCell]autorelease];
    }
    NSUInteger row = [indexPath row];
    ClassFIeld *the = [self.controllers objectAtIndex:row];
    cell.textLabel.text = the.title;
    return cell;
    
}

#pragma mark -
#pragma  mark Table Delegate Methods
//添加附属按钮
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row =indexPath.row;
    ClassFIeld *the = [self.controllers objectAtIndex:row];
    Detail *newView = [[Detail alloc] initWithStyle:UITableViewStyleGrouped];
    newView.title = the.title;
    newView.classField = the;
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    UINavigationController *nav = delegate.navController;
    [nav pushViewController:newView animated:YES];
    [newView release];

}



- (void)dealloc
{
    [super dealloc];
    [controllers release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.controllers = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
