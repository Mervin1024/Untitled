//
//  NoteBL.h
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteDAO.h"

#define IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

@interface NoteBL : NSObject

+ (NSMutableArray *)creatNote:(Note *)model;
+ (NSMutableArray *)remove:(Note *)model;
+ (NSMutableArray *)findAll;

@end
