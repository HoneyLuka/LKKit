//
//  NSString+LKUtils.m
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import "NSString+LKKit.h"

@implementation NSString (LKKit)

- (CGFloat)lk_heightForWidth:(CGFloat)width attributes:(NSDictionary *)attr
{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:attr
                                     context:nil];
    return ceilf(CGRectGetHeight(rect));
}

@end
