//
//  UIColor+LKUtils.m
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import "UIColor+LKKit.h"

@implementation UIColor (LKKit)

+ (UIColor *)lk_colorWithHexString:(NSString *)string
{
    //Color with string and a defualt alpha value of 1.0
    return [self lk_colorWithHexString:string withAlpha:1.0];
}

+ (UIColor *)lk_colorWithHexString:(NSString *)string withAlpha:(CGFloat)alpha
{
 
    //Quick return in case string is empty
    if (string.length == 0) {
        return nil;
    }
    
    //Check to see if we need to add a hashtag
    if('#' != [string characterAtIndex:0]) {
        string = [NSString stringWithFormat:@"#%@", string];
    }
    
    //Make sure we have a working string length
    if (string.length != 7 && string.length != 4) {
        
        #ifdef DEBUG
        NSLog(@"Unsupported string format: %@", string);
        #endif
        
        return nil;
    }
    
    //Check for short hex strings
    if(string.length == 4) {
        
        //Convert to full length hex string
        string = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                     [string substringWithRange:NSMakeRange(1, 1)],[string substringWithRange:NSMakeRange(1, 1)],
                     [string substringWithRange:NSMakeRange(2, 1)],[string substringWithRange:NSMakeRange(2, 1)],
                     [string substringWithRange:NSMakeRange(3, 1)],[string substringWithRange:NSMakeRange(3, 1)]];
    }
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(1, 2)]];
    unsigned red = [[self class] lk_hexValueToUnsigned:redHex];
    
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(3, 2)]];
    unsigned green = [[self class] lk_hexValueToUnsigned:greenHex];
    
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [string substringWithRange:NSMakeRange(5, 2)]];
    unsigned blue = [[self class] lk_hexValueToUnsigned:blueHex];
    
    return [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
}

+ (unsigned)lk_hexValueToUnsigned:(NSString *)hexValue
{
    
    //Define default unsigned value
    unsigned value = 0;
    
    //Scan unsigned value
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    //Return found value
    return value;
}

+ (UIColor *)lk_lightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor
{
    if (@available(iOS 13, *)) {
        UIColor *color = [UIColor colorWithDynamicProvider:
                          ^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection)
        {
            switch (traitCollection.userInterfaceStyle) {
                case UIUserInterfaceStyleLight:
                    return lightColor;
                default:
                    return darkColor;
            }
        }];
        
        return color;
    }
    
    return darkColor;
}

@end
