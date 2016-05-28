//
//  LCNWebImageOperation.m
//  LCNWebImage
//
//  Created by 梁川楠 on 16/5/27.
//  Copyright © 2016年 liangLiang. All rights reserved.
//

#import "LCNWebImageOperation.h"
#import "NSString+SandBoxPath.h"

@implementation LCNWebImageOperation

- (void)main {
    
    @autoreleasepool {
        
//        NSLog(@"下载图片:%@", [NSThread currentThread]);
        
        NSURL *url = [NSURL URLWithString:self.urlString];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // MARK: - 如果下载成功, 就把二进制数据存入到沙盒中
        if (data) {
            
            NSString *filePath = [self.urlString sandBoxCachesFilePath];
            
            [data writeToFile:filePath atomically:YES];
        }
        
        
        UIImage *image = [UIImage imageWithData:data];
        
        // 下载完毕之后的回调
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.block) {
                
                self.block(image);
            }
            
            // 传递图片
//            NSLog(@"传递图片:%@", [NSThread currentThread]);
        });
        
    }
}

- (void)downloadWebImageWithUrlString:(NSString *)urlString andWithBlcok:(downloadWedImageBlock)block {
    
    self.urlString = urlString;
    self.block = block;
    
}

@end
