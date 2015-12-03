//
//  DetailViewController.m
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "DetailViewController.h"
#import "NoteBL.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (IPHONE) {
        [self showNote:self.note];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showNote:(Note *)model{
    self.detailTextView.text = model.content;
}

- (IBAction)backAciton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
