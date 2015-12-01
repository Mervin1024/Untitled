//
//  ViewController.m
//  MyPhoneGap
//
//  Created by sh219 on 15/12/1.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mWebView;

@end

@implementation ViewController
@synthesize mWebView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // url = 'my://ViewController.HelloWorld#' + msg
    
    NSString *scheme = request.URL.scheme;  // my
    
    NSString *actionType = request.URL.host; // ViewController.HelloWorld
    
    NSString *fragment = [request.URL.fragment stringByRemovingPercentEncoding]; // msg
    
    if ([scheme isEqualToString:@"my"]) {
        if ([actionType isEqualToString:@"ViewController.HelloWorld"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"HelloWorld" message:fragment preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    return YES;
}

@end
