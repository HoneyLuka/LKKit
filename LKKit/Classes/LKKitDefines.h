//
//  LKKitDefines.h
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import <UIKit/UIKit.h>
#import <LKFoundation/LKFoundation.h>

#pragma mark - Macros

#define LK_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define LK_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define LK_SCREEN_SCALE [UIScreen mainScreen].scale

#define LK_DEGREES_TO_RADIANS(degrees) ((degrees) / 180.0 * M_PI)

#pragma mark - Blocks

typedef void(^LKUIImageBlock)(UIImage *);

#pragma mark - Animations

UIKIT_EXTERN void lk_no_anim_block(LKVoidBlock block);
UIKIT_EXTERN void lk_fade_transition(NSTimeInterval duration, UIView *view, LKVoidBlock block);
UIKIT_EXTERN void lk_ui_fade_in(NSTimeInterval duration, UIView *view);
UIKIT_EXTERN void lk_ui_fade_out(NSTimeInterval duration, UIView *view);
