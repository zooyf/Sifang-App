//
//  testTableViewController.m
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/18.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import "testTableViewController.h"
#import "SFCDetailViewController.h"
#import "SFCCourses.h"

@interface testTableViewController ()

@end

@implementation testTableViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"课程表";
        self.tabBarItem.title = @"课程表";

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [[NSMutableArray alloc] init];

    SFCCourses *monday = [[SFCCourses alloc] init];
    monday.title =@"星期一";
    [array addObject:monday];

    SFCCourses *tuesday = [[SFCCourses alloc] init];
    tuesday.title = @"星期二";
    [array addObject:tuesday];

    SFCCourses *wednesday = [[SFCCourses alloc] init];
    wednesday.title = @"星期三";
    [array addObject:wednesday];

    SFCCourses *thursday=[[SFCCourses alloc] init];
    thursday.title = @"星期四";
    [array addObject:thursday];

    SFCCourses *friday = [[SFCCourses alloc] init];
    friday.title =@"星期五";
    [array addObject:friday];

    SFCCourses *saturday = [[SFCCourses alloc] init];
    saturday.title = @"星期六";
    [array addObject:saturday];

    SFCCourses *sunday = [[SFCCourses alloc] init];
    sunday.title = @"星期日";
    [array addObject:sunday];

    self.controllers = array ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.controllers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *RootViewControllerCell =@"RootViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RootViewControllerCell];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RootViewControllerCell];
    }
    NSUInteger row = [indexPath row];
    SFCCourses *theCourse = [self.controllers objectAtIndex:row];
    cell.textLabel.text = theCourse.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row =indexPath.row;
    SFCCourses *theClass = [self.controllers objectAtIndex:row];
    SFCDetailViewController *newView = [[SFCDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
    newView.title = theClass.title;
    newView.courseInfo = theClass;

    [self.navigationController pushViewController:newView animated:YES];

}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
