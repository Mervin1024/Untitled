//
//  NoteDAO.m
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "NoteDAO.h"

@implementation NoteDAO
static NoteDAO *sharedManager = nil;

- (instancetype)init{
    if ((self = [super init])) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date1 = [dateFormatter dateFromString:@"2010-08-04 16:01:03"];
        Note *note1 = [[Note alloc] init];
        note1.date = date1;
        note1.content = @"Welcome to MyNotes.";
        
        NSDate *date2 = [dateFormatter dateFromString:@"2011-12-04 16:01:03"];
        Note *note2 = [[Note alloc] init];
        note2.date = date2;
        note2.content = @"欢迎使用MyNotes";
        
        _listData = [[NSMutableArray alloc] init];
        [_listData addObject:note1];
        [_listData addObject:note2];
    }
    return self;
}

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager = [[self alloc] init];
        
    });
    return sharedManager;
};

- (NSInteger)creat:(Note *)model{
    [self.listData addObject:model];
    return 0;
}

- (NSInteger)remove:(Note *)model{
    for (Note *note in self.listData) {
        if ([note.date isEqualToDate:model.date]) {
            [self.listData removeObject:note];
            break;
        }
    }
    return 0;
}

- (NSInteger)modify:(Note *)model{
    for (Note *note in self.listData) {
        if ([note.date isEqualToDate:model.date]) {
            note.content = model.content;
            break;
        }
    }
    return 0;
}

- (NSMutableArray *)findAll{
    return self.listData;
}

- (Note *)findById:(Note *)model{
    for (Note *note in self.listData) {
        if ([note.date isEqualToDate:model.date]) {
            return note;
        }
    }
    return nil;
}

@end
