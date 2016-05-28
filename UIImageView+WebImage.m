//
//  UIImageView+WebImage.m
//  LCNWebImage
//
//  Created by 梁川楠 on 16/5/27.
//  Copyright © 2016年 liangLiang. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import "LCNWebImageManager.h"

@implementation UIImageView (WebImage)

- (void)lcn_setUpImageWithUrlString:(NSString *)urlString andWithPlaceholderImage:(UIImage *)image {
    
    // 先设置占位图片, 再下载图片, 然后再显示图片
    // 1.占位图片
    self.image = image;
    
    // 2.创建管理者, 通过管理者管理图片
    LCNWebImageManager *manager = [LCNWebImageManager sharedManager];
    
    [manager setUpWebImageWithUrlString:urlString andWithSetUpImageBlock:^(UIImage *image) {
        
        self.image = image;
        
//        NSLog(@"显示图片:%@", [NSThread currentThread]);
    }];
}

@end
