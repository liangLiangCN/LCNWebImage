//
//  LCNWebImageManager.h
//  LCNWebImage
//
//  Created by 梁川楠 on 16/5/27.
//  Copyright © 2016年 liangLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCNWebImageOperation;
typedef void(^setUpWebImageBlock)(UIImage *image);
@interface LCNWebImageManager : NSObject

@property (nonatomic,copy) setUpWebImageBlock block;

- (void)setUpWebImageWithUrlString:(NSString *)urlString andWithSetUpImageBlock:(setUpWebImageBlock)block;

// 单例
+ (instancetype)sharedManager;

@end
