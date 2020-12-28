//
//  UIView+LKUtils.h
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LKKit)

@property (nonatomic, assign) CGFloat lk_left;
@property (nonatomic, assign) CGFloat lk_top;
@property (nonatomic, assign, readonly) CGFloat lk_right;
@property (nonatomic, assign, readonly) CGFloat lk_bottom;
@property (nonatomic, assign) CGFloat lk_width;
@property (nonatomic, assign) CGFloat lk_height;
@property (nonatomic, assign) CGPoint lk_origin;
@property (nonatomic, assign) CGSize lk_size;

- (void)lk_removeAllSubviews;
- (UIImage *)lk_snapshotImage;
- (UIImage *)lk_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;
- (NSData *)lk_snapshotPDF;
- (UIViewController *)lk_viewController;

@end

NS_ASSUME_NONNULL_END
