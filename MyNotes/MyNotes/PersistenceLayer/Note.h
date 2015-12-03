//
//  Note.h
//  MyNotes
//
//  Created by sh219 on 15/12/3.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *content;
@end
