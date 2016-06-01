//
//  MOFoodListViewController.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/1.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "MOFoodListViewController.h"
#import "Food.h"

@interface MOFoodListCell ()
{
    Food *_food; //该属性同时实现了setter和getter方法，需要作此声明
}

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet       UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;

@property (nonatomic, strong) Food *food;

@property (nonatomic, copy) void(^completionBlock)(Food * food);

@end

@implementation MOFoodListCell

- (void)awakeFromNib {
    
    self.addBtn.hidden = YES;
    [self setHiddenOfCancelBtn:true completeBtn:true editBtn:![AppConfig isManagerUser]];
}

- (Food *)food {
    if (!_food) {
        _food = [Food object];
    }
    return _food;
}

- (void)setFood:(Food *)food {
    _food = food;
    
    self.nameTF.text = food.name;
    self.priceTF.text= S(@"%@", food.price ? : @"");
    
    [self setHiddenOfCancelBtn:YES completeBtn:YES editBtn:![AppConfig isManagerUser]];
}

- (void)setHiddenOfCancelBtn:(BOOL)cancelHidden completeBtn:(BOOL)completeHidden editBtn:(BOOL)editHidden {
    [self.contentView endEditing:cancelHidden];
    
    self.cancelBtn.hidden = cancelHidden;
    self.completeBtn.hidden = completeHidden;
    self.editBtn.hidden = editHidden;
    
    BOOL addBtnDisplaying = cancelHidden && completeHidden && editHidden;
    self.addBtn.hidden = !addBtnDisplaying;
    
    self.nameTF.enabled = !cancelHidden || addBtnDisplaying;
    self.priceTF.enabled = !cancelHidden || addBtnDisplaying;
}

- (IBAction)cancelAction:(id)sender {
    [self setFood:self.food];
    
    [self setHiddenOfCancelBtn:YES completeBtn:YES editBtn:NO];
}

- (IBAction)editAction:(id)sender {
    
    [self setHiddenOfCancelBtn:NO completeBtn:NO editBtn:YES];
    
    [self.nameTF becomeFirstResponder];
}

- (IBAction)completeAction:(id)sender {
    
    if ([self verifyInputContents]) {
        [self setHiddenOfCancelBtn:YES completeBtn:YES editBtn:NO];
    }
    
}

- (IBAction)addAction:(id)sender {
    [self.contentView endEditing:YES];
    
    if (![self verifyInputContents]) {
        return;
    }
    
    BlockCallWithOneArg(self.completionBlock, self.food);
    
}

- (BOOL)verifyInputContents {
    [YFEasyHUD showIndicator];
    
    if (StringIsNullOrEmpty(self.nameTF.text)) {
        [YFEasyHUD showMsg:@"更新失败" details:@"您未输入名称" lastTime:1.5];
        [self.nameTF becomeFirstResponder];
        return NO;
    }
    if (StringIsNullOrEmpty(self.nameTF.text)) {
        [YFEasyHUD showMsg:@"更新失败" details:@"您未输入价格" lastTime:1.5];
        [self.priceTF becomeFirstResponder];
        return NO;
    }

    
    self.food.name = self.nameTF.text;
    self.food.price = (NSNumber *)self.priceTF.text;
    
    [self.contentView endEditing:YES];
    
    NSError *error = nil;
    [self.food save:&error];
    
    if (error) {
        [YFEasyHUD showMsg:@"更新失败" details:@"请检查网络" lastTime:1.5];
        return NO;
    }
    
    [YFEasyHUD hideHud];
    
    return YES;

}

@end


#pragma mark -- MOFoodListViewController --

@interface MOFoodListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation MOFoodListViewController
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];;
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([AppConfig isManagerUser]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    [self.tableView setAllowsSelection:NO];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    [YFEasyHUD showIndicator];
    
    AVQuery *query = [AVQuery queryWithClassName:kFoodName];
    [query whereKey:@"stall" equalTo:self.stall];
    
    IMP_BLOCK_SELF(MOFoodListViewController)
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [YFEasyHUD hideHud];
        if (error) {
            [YFEasyHUD showMsg:@"请求失败" details:@"请检查网络" lastTime:1.5];
        }
        
        [block_self.dataList addObjectsFromArray:objects];
        [block_self.tableView reloadData];
    }];
    
    
}

- (void)back {
    [[NSNotificationCenter defaultCenter] postNotificationName:kPostNotificationStallListRefresh object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- TableViewDataSource --

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IMP_BLOCK_SELF(MOFoodListViewController)
    
    MOFoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MOFoodListCell"];
    
    NSInteger currentRowNumber = indexPath.row;
    
    
    if (self.dataList.count == currentRowNumber && [AppConfig isManagerUser]) {
        //表示最后一行,即添加行
        
        [cell setHiddenOfCancelBtn:YES completeBtn:YES editBtn:YES];
        
        cell.food.stall = self.stall;
        cell.food.order = @(currentRowNumber);
        
        [cell setCompletionBlock:^(Food *food) {
            [block_self.dataList addObject:food];
            [block_self.tableView reloadData];
        }];
    } else {
        
        cell.food = self.dataList[indexPath.row];
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count + [AppConfig isManagerUser];
}


#pragma mark -- UITableViewDelegate --

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AppConfig isManagerUser];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL lastCell = self.dataList.count == indexPath.row;
    
    return lastCell ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.dataList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


#pragma mark -- Segue method --

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end
