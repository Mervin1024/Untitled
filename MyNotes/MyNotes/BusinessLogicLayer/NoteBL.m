//
//  NoteBL.m
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "NoteBL.h"

@implementation NoteBL

+ (NSMutableArray *)creatNote:(Note *)model{
    NoteDAO *dao = [NoteDAO shareManager];
    [dao creat:model];
    return [dao findAll];
}

+ (NSMutableArray *)remove:(Note *)model{
    NoteDAO *dao = [NoteDAO shareManager];
    [dao remove:model];
    return [dao findAll];
}

+ (NSMutableArray *)findAll{
    NoteDAO *dao = [NoteDAO shareManager];
    return [dao findAll];
}

@end
