//
//  LKAppearance.h
//  LKKit
//
//  Created by Selina on 29/12/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 app_appearance.json
 
 {
    "light": {
        "themeColor": "#333333"
    },
    "dark": {
        "themeColor": "#333333"
    }
 }
 */

@interface LKAppearance : NSObject

+ (void)configWithAppearanceData:(NSData *)data;

+ (UIColor *)themeColor;
+ (UIColor *)bgColor;
+ (UIColor *)secondaryBgColor;
+ (UIColor *)tertiaryBgColor;
+ (UIColor *)labelColor;
+ (UIColor *)secondaryLabelColor;
+ (UIColor *)tertiaryLabelColor;
+ (UIColor *)placeholderTextColor;
+ (UIColor *)infoColor;
+ (UIColor *)successColor;
+ (UIColor *)errorColor;

@end

NS_ASSUME_NONNULL_END
