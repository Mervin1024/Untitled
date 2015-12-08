//
//  ViewController.h
//  TextKit_Sample
//
//  Created by sh219 on 15/12/8.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSTextContainer *textContainer;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)markWord:(NSString *)word inTextStorage:(NSTextStorage *)textStorage;

@end

