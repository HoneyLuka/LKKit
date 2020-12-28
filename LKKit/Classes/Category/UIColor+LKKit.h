//
//  UIColor+LKUtils.h
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import <UIKit/UIKit.h>

#define LK_COLOR_HEX(hex) [UIColor lk_colorWithHexString:hex]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LKKit)

+ (nullable instancetype)lk_colorWithHexString:(NSString *)hexString;
+ (nullable instancetype)lk_colorWithHexString:(NSString *)string withAlpha:(CGFloat)alpha;
+ (nullable instancetype)lk_lightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
