//
//  ViewController.m
//  AppSetting
//
//  Created by 马遥 on 15/12/23.
//  Copyright © 2015年 Mervin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *password;
@property (weak, nonatomic) IBOutlet UILabel *clearCache;
@property (weak, nonatomic) IBOutlet UILabel *flowmeter;
@property (weak, nonatomic) IBOutlet UILabel *serverName;
@property (weak, nonatomic) IBOutlet UILabel *notiSound;
@property (weak, nonatomic) IBOutlet UILabel *notiVibrate;
- (IBAction)getData:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getData:(id)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.username.text = [NSString stringWithFormat:@"    用户名         %@",[defaults stringForKey:@"name_preference"]];
    self.password.text = [NSString stringWithFormat:@"    密码             %@",[defaults stringForKey:@"password_preference"]];
    
    if ([defaults boolForKey:@"enabled_preference"]) {
        self.clearCache.text = @"    每月是否清除缓存       YES";
    }else{
        self.clearCache.text = @"    每月是否清除缓存       NO";
    }
    
    self.flowmeter.text = [NSString stringWithFormat:@"    每月流量限制               %.2fGB",[defaults doubleForKey:@"slider_preference"]];
    self.serverName.text = [NSString stringWithFormat:@"    服务器                           %@",[defaults stringForKey:@"multivaule_preference"]];
    if ([defaults boolForKey:@"sound_enabled_preference"]) {
        self.notiSound.text = @"    通知-声音                     YES";
    }else{
        self.notiSound.text = @"    通知-声音                     NO";
    }
    if ([defaults boolForKey:@"vibrate_enabled_preference"]) {
        self.notiVibrate.text = @"    通知-振动                     YES";
    }else{
        self.notiVibrate.text = @"    通知-振动                     NO";
    }
}
@end
