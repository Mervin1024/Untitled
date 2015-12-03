//
//  DetailViewController.h
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteDAO.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Note *note;

- (void)showNote:(Note *)model;
@end
