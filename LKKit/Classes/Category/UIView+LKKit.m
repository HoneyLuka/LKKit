//
//  UIView+LKUtils.m
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import "UIView+LKKit.h"

@implementation UIView (LKKit)

- (CGFloat)lk_left
{
    return CGRectGetMinX(self.frame);
}

- (void)setLk_left:(CGFloat)lk_left
{
    CGRect frame = self.frame;
    frame.origin.x = lk_left;
    self.frame = frame;
}

- (CGFloat)lk_top
{
    return CGRectGetMinY(self.frame);
}

- (void)setLk_top:(CGFloat)lk_top
{
    CGRect frame = self.frame;
    frame.origin.y = lk_top;
    self.frame = frame;
}

- (CGFloat)lk_width
{
    return CGRectGetWidth(self.frame);
}

- (void)setLk_width:(CGFloat)lk_width
{
    CGRect frame = self.frame;
    frame.size.width = lk_width;
    self.frame = frame;
}

- (CGFloat)lk_height
{
    return CGRectGetHeight(self.frame);
}

- (void)setLk_height:(CGFloat)lk_height
{
    CGRect frame = self.frame;
    frame.size.height = lk_height;
    self.frame = frame;
}

- (CGPoint)lk_origin
{
    return self.frame.origin;
}

- (void)setLk_origin:(CGPoint)lk_origin
{
    CGRect frame = self.frame;
    frame.origin = lk_origin;
    self.frame = frame;
}

- (CGSize)lk_size
{
    return self.frame.size;
}

- (void)setLk_size:(CGSize)lk_size
{
    CGRect frame = self.frame;
    frame.size = lk_size;
    self.frame = frame;
}

- (CGFloat)lk_right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)lk_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)lk_removeAllSubviews
{
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (UIImage *)lk_snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)lk_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates
{
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self lk_snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)lk_snapshotPDF
{
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (UIViewController *)lk_viewController
{
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
