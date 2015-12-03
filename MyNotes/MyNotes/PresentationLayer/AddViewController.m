//
//  AddViewController.m
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "AddViewController.h"
#import "NoteBL.h"

@interface AddViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *addTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@end

@implementation AddViewController
@synthesize addTextView,saveButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addTextView.text = @"";
    self.saveButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        saveButton.enabled = NO;
    }else{
        saveButton.enabled = YES;
    }
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveAction:(id)sender {
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    Note *note = [[Note alloc] init];
    note.date = date;
    note.content = self.addTextView.text;
    [NoteBL creatNote:note];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addNote" object:nil];
    [self cancelAction:sender];
}

@end
