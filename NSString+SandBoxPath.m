//
//  NSString+SandBoxPath.m
//  LCNWebImage
//
//  Created by 梁川楠 on 16/5/28.
//  Copyright © 2016年 liangLiang. All rights reserved.
//

#import "NSString+SandBoxPath.h"

@implementation NSString (SandBoxPath)


- (NSString *)sandBoxCachesFilePath {
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    filePath = [filePath stringByAppendingPathComponent:self.lastPathComponent];
    
    return filePath;
    
}
@end
