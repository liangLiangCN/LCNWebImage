//
//  NSString+SandBoxPath.h
//  LCNWebImage
//
//  Created by 梁川楠 on 16/5/28.
//  Copyright © 2016年 liangLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SandBoxPath)

// 获取caches路径并且拼接
- (NSString *)sandBoxCachesFilePath;

@end
