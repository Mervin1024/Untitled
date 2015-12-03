//
//  ViewController.m
//  WebViewTest
//
//  Created by sh219 on 15/12/1.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()<UIWebViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation MasterViewController
@synthesize myWebView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebView{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:request];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tap.delegate = self;
    tap.cancelsTouchesInView = NO;
    [myWebView addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)sender{
    NSLog(@"handle");
    CGPoint pt = [sender locationInView:myWebView];
    NSLog(@"pt:%@",NSStringFromCGPoint(pt));
    NSString *executeURL = [NSString stringWithFormat:@"document.elementFromPoint(%f,%f).tagName",pt.x,pt.y];
//    NSString *executeURL = [NSString stringWithFormat:@"document.elementFromPoint(%f,%f).parentElement.type",pt.x,pt.y];
    NSString *urlToSave = [myWebView stringByEvaluatingJavaScriptFromString:executeURL];
    NSLog(@"urlToSave:%@",urlToSave);
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSLog(@"2");
//    NSString *urlString = request.URL.relativeString;
//    NSLog(@"urlString:%@",urlString);
//    NSLog(@"navigationType:%ld",(long)navigationType);
////    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"新闻" preferredStyle:UIAlertControllerStyleAlert];
////    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
////    if ([self stringA:urlString containsStringB:@"news"]) {
////        alertController.message = @"新闻";
////        [self presentViewController:alertController animated:YES completion:nil];
////        return NO;
////    }else if ([self stringA:urlString containsStringB:@"video"]){
////        alertController.message = @"视频";
////        [self presentViewController:alertController animated:YES completion:nil];
////        return NO;
////    }else if ([self stringA:urlString containsStringB:@"dushu"]){
////        alertController.message = @"小说";
////        [self presentViewController:alertController animated:YES completion:nil];
////        return NO;
////    }else if ([self stringA:urlString containsStringB:@"life"]){
////        alertController.message = @"生活";
////        [self presentViewController:alertController animated:YES completion:nil];
////        return NO;
////    }
    
    return YES;
}
//
//- (BOOL)stringA:(NSString *)stringA containsStringB:(NSString *)stringB{
//    NSRange range = [stringA rangeOfString:stringB options:NSCaseInsensitiveSearch];
//    if (range.length > 0) {
//        return YES;
//    }else{
//        return NO;
//    }
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    NSLog(@"1");
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSLog(@"3");
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    NSLog(@"4");
//}

@end
