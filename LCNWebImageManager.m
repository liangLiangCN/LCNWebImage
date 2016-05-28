//
//  LCNWebImageManager.m
//  LCNWebImage
//
//  Created by 梁川楠 on 16/5/27.
//  Copyright © 2016年 liangLiang. All rights reserved.
//

#import "LCNWebImageManager.h"
#import "LCNWebImageOperation.h"
#import "NSString+SandBoxPath.h"


@interface LCNWebImageManager ()

@property (nonatomic,strong) NSOperationQueue *queue;

#warning 此处用的可变字典, 不能自动清除缓存. 等学了NSCache之后, 把可变字典更改, 当接收到内存警告时, 可自动清除缓存, 不用再手动操作!
// 图片缓存
@property (nonatomic,strong) NSMutableDictionary *imageDictM;

// 操作缓存
@property (nonatomic,strong) NSMutableDictionary *operationDictM;

@end
@implementation LCNWebImageManager

// 管理者负责管理操作. 操作负责下载图片. 当操作下载好图片之后, 把图片传递给管理者, 管理者设置一些内容, 然后把图片传给imageView的分类. 这个分类负责显示图片

- (void)setUpWebImageWithUrlString:(NSString *)urlString andWithSetUpImageBlock:(setUpWebImageBlock)block {
    
    // MARK: - 1.先从图片缓存中取图片
    if (self.imageDictM[urlString]) {
        
        UIImage *image = self.imageDictM[urlString];
        
        if (block) {
            block(image);
        }
        
        return;
    }
    
    // MARK: - 2.图片缓存中没有, 就去沙盒找
    NSString *filePath = [urlString sandBoxCachesFilePath];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    if (image) {
        
        if (block) {
            
            block(image);
        }
        
        // 并把图片添加到图片缓存中, 避免沙盒的IO操作
        [self.imageDictM setObject:image forKey:urlString];
    }
    
    // MARK: - 3.沙盒中没有就重新下载,先查看有没有正在下载的操作
    if (self.operationDictM[urlString]) {
        
        return;
    }
    
    // MARK: - 4.没有操作重新创建操作
    // 创建操作
    LCNWebImageOperation *operation = [[LCNWebImageOperation alloc] init];
    
    [operation downloadWebImageWithUrlString:urlString andWithBlcok:^(UIImage *image) {
        
        if (block) {
            
            block(image);
        }
        
        // 图片下载成功, 存到图片缓存中
        if (image) {
            
            [self.imageDictM setObject:image forKey:urlString];
            
            // 图片下载成功之后, 可把对应的操作移除掉
            [self.operationDictM removeObjectForKey:urlString];
        }        
        
    }];
    
//    [self.queue setma]
    
    // 把操作添加到操作缓存中
    [self.operationDictM setObject:operation forKey:urlString];
    
    // 把操作添加到队列中
    [self.queue addOperation:operation];
    
    

}


#pragma mark - 单例
+ (instancetype)sharedManager {
    
    static id _instance;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        _instance = [[self alloc] init];
        
    });
    
    return _instance;
    
    
}

#pragma mark - 实例化
- (NSOperationQueue *)queue {
    
    if (_queue == nil) {
        
        _queue = [[NSOperationQueue alloc] init];
        
        // 设置最大并发数
        [_queue setMaxConcurrentOperationCount:6];
    }
    
    return _queue;
}

- (NSMutableDictionary *)imageDictM {
    
    if (_imageDictM == nil) {
        
        _imageDictM = [[NSMutableDictionary alloc] init];
    }
    
    return _imageDictM;
}

- (NSMutableDictionary *)operationDictM {
    
    if (_operationDictM == nil) {
        
        _operationDictM = [[NSMutableDictionary alloc] init];
    }
    
    return _operationDictM;
}

@end
