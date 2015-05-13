//
//  SFCTimeTableTableViewController.m
//  Sifang Assistant By code
//
//  Created by YesterdayFinder on 15/5/12.
//  Copyright (c) 2015年 YesterdayFinder. All rights reserved.
//

#import "SFCTimeTableTableViewController.h"
#import "ClassFIeld.h"
#import "Detail.h"
#import "AppDelegate.h"

@interface SFCTimeTableTableViewController ()

@end

@implementation SFCTimeTableTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"课程表";
        self.tabBarItem.title = @"课程表";
        self.navigationController.navigationItem.leftBarButtonItem.title = @"cancel";
        //        UIImage *image = [UIImage imageNamed:@"Timetable.png"];
        //        self.tabBarItem.image = image;
    }
    NSLog(@"initWithNibName:");
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    ClassFIeld *monday = [[ClassFIeld alloc] init];
    monday.title =@"星期一";
    [array addObject:monday];
    
    ClassFIeld *tuesday = [[ClassFIeld alloc] init];
    tuesday.title = @"星期二";
    [array addObject:tuesday];
    
    ClassFIeld *wednesday = [[ClassFIeld alloc] init];
    wednesday.title = @"星期三";
    [array addObject:wednesday];
    
    ClassFIeld *thursday=[[ClassFIeld alloc] init];
    thursday.title = @"星期四";
    [array addObject:thursday];
    
    ClassFIeld *friday = [[ClassFIeld alloc] init];
    friday.title =@"星期五";
    [array addObject:friday];
    
    ClassFIeld *saturday = [[ClassFIeld alloc] init];
    saturday.title = @"星期六";
    [array addObject:saturday];
    
    ClassFIeld *sunday = [[ClassFIeld alloc] init];
    sunday.title = @"星期日";
    [array addObject:sunday];
    
    self.controllers = array ;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

#pragma  mark TableView Data Source Methods

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
    ClassFIeld *the = [self.controllers objectAtIndex:row];
    cell.textLabel.text = the.title;
    
    return cell;
}

#pragma  mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row =indexPath.row;
    ClassFIeld *theClass = [self.controllers objectAtIndex:row];
    Detail *newView = [[Detail alloc] initWithStyle:UITableViewStyleGrouped];
    newView.title = theClass.title;
    newView.classField = theClass;
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    UINavigationController *nav = delegate.navController;
    [nav pushViewController:newView animated:YES];
    
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
