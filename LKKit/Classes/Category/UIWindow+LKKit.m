//
//  UIWindow+LKUtils.m
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import "UIWindow+LKKit.h"

@implementation UIWindow (LKKit)

+ (nullable instancetype)lk_frontWindow
{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = window.windowLevel == UIWindowLevelNormal;
        BOOL windowKeyWindow = window.isKeyWindow;
            
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
    
    return nil;
}

@end
