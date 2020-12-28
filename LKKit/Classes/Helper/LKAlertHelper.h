//
//  LKAlertHelper.h
//  LKImageInfoViewer
//
//  Created by Luka Li on 4/3/2020.
//  Copyright © 2020 Luka Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LKAlertHelperVoidBlock)(void);

@interface LKAlertHelper : NSObject

+ (void)showInfo:(NSString *)title
            desc:(NSString *)desc
      dangerText:(NSString *)dangerText
         confirm:(LKAlertHelperVoidBlock)confirmBlock;

+ (void)showInfo:(NSString *)title
            desc:(NSString *)desc
      cancelText:(NSString *)cancelText
     confirmText:(NSString *)confirmText
           style:(UIAlertActionStyle)confirmStyle
    confirmBlock:(LKAlertHelperVoidBlock)confirmBlock
     cancelBlock:(LKAlertHelperVoidBlock)cancelBlock;

+ (void)showActionSheet:(NSString *)title
                   desc:(NSString *)desc
                actions:(NSArray<UIAlertAction *> *)actions;

+ (void)showActionSheet:(NSString *)title
                   desc:(NSString *)desc
                actions:(NSArray<UIAlertAction *> *)actions
                barItem:(UIBarButtonItem *)barItem;

+ (void)showActionSheet:(NSString *)title
                   desc:(NSString *)desc
             cancelText:(NSString *)cancelText
                actions:(NSArray<UIAlertAction *> *)actions
            cancelBlock:(LKAlertHelperVoidBlock)cancelBlock
             sourceView:(UIView *)sourceView
             sourceRect:(CGRect)sourceRect
                barItem:(UIBarButtonItem *)barItem;

+ (void)showLoadingHUD;
+ (void)showLoadingHUDAllowUserInterAction:(BOOL)allow;
+ (void)showSuccessHUD:(NSString *)str;
+ (void)showErrorHUD:(NSString *)str;
+ (void)dismissHUD;

@end
