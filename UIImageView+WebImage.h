//
//  UIImageView+WebImage.h
//  LCNWebImage
//
//  Created by 梁川楠 on 16/5/27.
//  Copyright © 2016年 liangLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebImage)

- (void)lcn_setUpImageWithUrlString:(NSString *)urlString andWithPlaceholderImage:(UIImage *)image;

@end
