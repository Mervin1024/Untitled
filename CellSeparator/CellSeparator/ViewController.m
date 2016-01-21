//
//  ViewController.m
//  CellSeparator
//
//  Created by sh219 on 16/1/19.
//  Copyright © 2016年 sh219. All rights reserved.
//

#import "ViewController.h"
#import "AATableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
@synthesize tableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    tableView.separatorColor = [UIColor redColor];
//    [tableView setSeparatorInset:UIEdgeInsetsZero];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AATableViewCell *cell = [[AATableViewCell alloc] init];
//    cell.backgroundColor = [UIColor yellowColor];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.text = @"11111111";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

@end
