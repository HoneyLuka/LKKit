//
//  LKAlertHelper.m
//  LKImageInfoViewer
//
//  Created by Luka Li on 4/3/2020.
//  Copyright © 2020 Luka Li. All rights reserved.
//

#import "LKAlertHelper.h"
#import <LKFoundation/LKFoundation.h>
#import "UIWindow+LKKit.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation LKAlertHelper

+ (void)showInfo:(NSString *)title
            desc:(NSString *)desc
      dangerText:(NSString *)dangerText
         confirm:(LKAlertHelperVoidBlock)confirmBlock
{
    [self showInfo:title desc:desc
        cancelText:@"Cancel"
       confirmText:dangerText
             style:UIAlertActionStyleDestructive
      confirmBlock:confirmBlock
       cancelBlock:nil];
}

+ (void)showInfo:(NSString *)title
            desc:(NSString *)desc
      cancelText:(NSString *)cancelText
     confirmText:(NSString *)confirmText
           style:(UIAlertActionStyle)confirmStyle
    confirmBlock:(LKAlertHelperVoidBlock)confirmBlock
     cancelBlock:(LKAlertHelperVoidBlock)cancelBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:desc
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText
                                                           style:UIAlertActionStyleCancel
                                                         handler:
                                   ^(UIAlertAction * _Nonnull action) {
        LK_SAFE_BLOCK(cancelBlock);
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmText
                                                            style:confirmStyle
                                                          handler:
                                    ^(UIAlertAction * _Nonnull action) {
        LK_SAFE_BLOCK(confirmBlock);
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    
    UIViewController *vc = [UIWindow lk_frontWindow].rootViewController;
    
    alertController.popoverPresentationController.sourceView = vc.view;
    alertController.popoverPresentationController.sourceRect = vc.view.bounds;
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)showActionSheet:(NSString *)title
                   desc:(NSString *)desc
                actions:(NSArray<UIAlertAction *> *)actions
{
    [self showActionSheet:title desc:desc actions:actions barItem:nil];
}

+ (void)showActionSheet:(NSString *)title
                   desc:(NSString *)desc
                actions:(NSArray<UIAlertAction *> *)actions
                barItem:(UIBarButtonItem *)barItem
{
    [self showActionSheet:title desc:desc cancelText:@"Cancel" actions:actions cancelBlock:nil sourceView:nil sourceRect:CGRectZero barItem:barItem];
}

+ (void)showActionSheet:(NSString *)title
                   desc:(NSString *)desc
             cancelText:(NSString *)cancelText
                actions:(NSArray<UIAlertAction *> *)actions
            cancelBlock:(LKAlertHelperVoidBlock)cancelBlock
             sourceView:(UIView *)sourceView
             sourceRect:(CGRect)sourceRect
                barItem:(UIBarButtonItem *)barItem
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:desc
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelText
                                                           style:UIAlertActionStyleCancel
                                                         handler:
                                   ^(UIAlertAction * _Nonnull action) {
        LK_SAFE_BLOCK(cancelBlock);
    }];
    
    [alertController addAction:cancelAction];
    
    UIViewController *vc = [UIWindow lk_frontWindow].rootViewController;
    if (!sourceView) {
        sourceView = vc.view;
        sourceRect = vc.view.bounds;
    }
    
    alertController.popoverPresentationController.sourceView = sourceView;
    alertController.popoverPresentationController.sourceRect = sourceRect;
    alertController.popoverPresentationController.barButtonItem = barItem;
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)showLoadingHUD
{
    [self showLoadingHUDAllowUserInterAction:NO];
}

+ (void)showLoadingHUDAllowUserInterAction:(BOOL)allow
{
    if (allow) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    } else {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    
    [SVProgressHUD show];
}

+ (void)showSuccessHUD:(NSString *)str
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showSuccessWithStatus:str];
}

+ (void)showErrorHUD:(NSString *)str
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showErrorWithStatus:str];
}

+ (void)dismissHUD
{
    [SVProgressHUD dismiss];
}

@end
