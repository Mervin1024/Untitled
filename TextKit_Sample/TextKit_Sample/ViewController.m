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
@synthesize textView, textContainer, imageView;
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
    newTextView.backgroundColor = [UIColor yellowColor];
    newTextView.text = textView.text;
    newTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];//调用系统字体大小
    [textView removeFromSuperview];
    [self.view insertSubview:newTextView belowSubview:imageView];
    //
    [textStorage beginEditing];
//    NSDictionary *attrsDic = @{NSTextEffectAttributeName:NSTextEffectLetterpressStyle};  //凸版印刷效果
//    
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:newTextView.text attributes:attrsDic];
//    
//    [textStorage setAttributedString:attrStr];
    [self markWord:@"我" inTextStorage:textStorage];
    [self markWord:@"I" inTextStorage:textStorage];
    
    [textStorage endEditing];
    
    newTextView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];// 系统字体改变
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)markWord:(NSString *)word inTextStorage:(NSTextStorage *)textStorage{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:word options:0 error:nil];
    //正则表达式
    NSArray *matches = [regex matchesInString:newTextView.text options:0 range:NSMakeRange(0, newTextView.text.length)];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        [textStorage addAttribute:NSForegroundColorAttributeName
                            value:[UIColor redColor]
                            range:matchRange];
        
    }
}

- (UIBezierPath *)translatedBezierPath{
    [self.view layoutIfNeeded];
    CGRect imageRect = [newTextView convertRect:imageView.frame fromView:self.view];
    UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:imageRect];
    return newPath;
    //贝塞尔曲线1111111111
}

- (void)preferredContentSizeChanged:(NSNotification *)notification{
    newTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

@end
