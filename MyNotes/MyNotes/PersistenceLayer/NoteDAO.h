//
//  NoteDAO.h
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface NoteDAO : NSObject

@property (nonatomic, strong) NSMutableArray *listData;
+ (instancetype)shareManager;

- (NSInteger)creat:(Note *)model;
- (NSInteger)remove:(Note *)model;
- (NSInteger)modify:(Note *)model;
- (NSMutableArray *)findAll;
- (Note *)findById:(Note *)model;
@end
