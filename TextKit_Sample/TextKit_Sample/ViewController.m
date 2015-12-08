//
//  ViewController.m
//  TextKit_Sample
//
//  Created by sh219 on 15/12/8.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UITextView *newTextView;
}

@end

@implementation ViewController
@synthesize textView, textContainer;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect textViewRect = CGRectInset(self.view.bounds, 10.0, 20.0);
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:textView.text];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    
    textContainer = [[NSTextContainer alloc] initWithSize:textViewRect.size];
    [layoutManager addTextContainer:textContainer];
    
    newTextView = [[UITextView alloc] initWithFrame:textViewRect textContainer:textContainer];
    newTextView.editable = NO;
    newTextView.text = textView.text;
    [textView removeFromSuperview];
    [self.view addSubview:newTextView];
    //凸版印刷效果
    [textStorage beginEditing];
    NSDictionary *attrsDic = @{NSTextEffectAttributeName:NSTextEffectLetterpressStyle};
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:newTextView.text attributes:attrsDic];
    
    [textStorage setAttributedString:attrStr];
    [self markWord:@"我" inTextStorage:textStorage];
    [self markWord:@"I" inTextStorage:textStorage];
    
    [textStorage endEditing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)markWord:(NSString *)word inTextStorage:(NSTextStorage *)textStorage{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:word options:0 error:nil];
    NSArray *matches = [regex matchesInString:newTextView.text options:0 range:NSMakeRange(0, newTextView.text.length)];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        [textStorage addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:matchRange];
        
    }
}

@end
