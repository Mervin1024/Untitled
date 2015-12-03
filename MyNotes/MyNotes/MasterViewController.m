//
//  ViewController.m
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterTableViewController (){
    DetailViewController *detailViewController;
}
@property (copy, nonatomic) NSArray *listData;
@end

@implementation MasterTableViewController
@synthesize listData;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self reloadTableView];
    if (IPAD) {
        detailViewController = (DetailViewController *)[self.splitViewController.viewControllers lastObject];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"addNote" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.tableView setEditing:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTableView{
    listData = [NoteBL findAll];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell"];
    if (cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NoteCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Note *note = [listData objectAtIndex:indexPath.row];
    cell.textLabel.text = note.content;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    cell.detailTextLabel.text = [formatter stringFromDate:note.date];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IPHONE) {
        [self performSegueWithIdentifier:@"ShowDetail" sender:[listData objectAtIndex:indexPath.row]];
    }else{
        [detailViewController showNote:[listData objectAtIndex:indexPath.row]];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        listData = [NoteBL remove:[listData objectAtIndex:indexPath.row]];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (IPAD) {
            [detailViewController showNote:nil];
        }
    }
}

- (IBAction)editAction:(id)sender {
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
    }else{
        [self.tableView setEditing:YES animated:YES];
    }
}

- (IBAction)addAction:(id)sender {
    if (IPAD) {
        AddViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddViewController"];
        controller.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        detailViewController = segue.destinationViewController;
        detailViewController.note = sender;
    }
}
@end
