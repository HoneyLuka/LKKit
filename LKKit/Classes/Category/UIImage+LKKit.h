//
//  UIImage+LKUtils.h
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LKKit)

- (nullable UIImage *)lk_imageWithTintColor:(UIColor *)color;

+ (nullable instancetype)lk_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
