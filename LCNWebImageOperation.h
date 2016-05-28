//
//  LCNWebImageOperation.h
//  LCNWebImage
//
//  Created by 梁川楠 on 16/5/27.
//  Copyright © 2016年 liangLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^downloadWedImageBlock)(UIImage *image);

@interface LCNWebImageOperation : NSOperation

@property (nonatomic,copy) NSString *urlString;

@property (nonatomic,copy) downloadWedImageBlock block;

- (void)downloadWebImageWithUrlString:(NSString *)urlString andWithBlcok:(downloadWedImageBlock)block;

@end
