//
//  ViewController.m
//  MVViewSwitchAnimation
//
//  Created by sh219 on 15/10/20.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "ViewAController.h"
#import "UIViewController+MVSwitchAnimation.h"

@interface ViewAController () {
}

@end

@implementation ViewAController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushView:(id)sender {
    ViewBController *viewBController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewBController"];
//    [self presentViewController:viewBController animated:YES completion:nil];
    [self switchViewController:viewBController animated:YES completion:^{
        NSLog(@"finished");
    }];
}

@end
