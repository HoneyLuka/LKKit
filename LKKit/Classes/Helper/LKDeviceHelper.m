//
//  LKDeviceHelper.m
//  LKImageInfoViewer
//
//  Created by Luka Li on 28/5/2020.
//  Copyright © 2020 Luka Li. All rights reserved.
//

#import "LKDeviceHelper.h"
#import "LKFoundationDefines.h"

@implementation LKDeviceHelper

+ (BOOL)isiPad
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

+ (BOOL)isiPhone
{
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

+ (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+ (UIEdgeInsets)safeAreaInsets
{
    if (@available(iOS 11, *)) {
        return [UIApplication sharedApplication].keyWindow.safeAreaInsets;
    }
    
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

+ (BOOL)isPhotoAuthorized
{
    PHAuthorizationStatus currentStatus = PHPhotoLibrary.authorizationStatus;
    
    switch (currentStatus) {
        case PHAuthorizationStatusAuthorized:
        case PHAuthorizationStatusLimited:
        {
            return YES;
        }
            break;
        default:
            return NO;
            break;
    }
}

+ (void)requestPhotoAuthorization:(LKPhotoAuthorizationCallback)callback
{
    void(^block)(PHAuthorizationStatus status) = ^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case PHAuthorizationStatusRestricted:
                case PHAuthorizationStatusDenied:
                {
                    LK_SAFE_BLOCK(callback, status, NO);
                }
                    break;
                case PHAuthorizationStatusAuthorized:
                case PHAuthorizationStatusLimited:
                {
                    LK_SAFE_BLOCK(callback, status, YES);
                }
                    break;
                    
                default:
                    break;
            }
        });
    };
    
    PHAuthorizationStatus currentStatus = PHPhotoLibrary.authorizationStatus;
    
    if (currentStatus != PHAuthorizationStatusNotDetermined) {
        // callback right now
        block(currentStatus);
        return;
    }
    
    // request user auth
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        block(status);
    }];
}

+ (void)openAppSettings
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

+ (NSString *)bundleId
{
    return [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleIdentifierKey];
}

+ (NSString *)appName
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
}

+ (NSString *)appVersion
{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildNumber
{
    id obj = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if ([obj isKindOfClass:NSNumber.class]) {
        return [obj stringValue];
    }
    
    return obj;
}

+ (void)feedbackTo:(NSString *)email
{
    NSString *appName = [self appName];
    NSString *subject = [NSString stringWithFormat:@"「%@ v%@」Feedback: ", appName, [self appVersion]];
    
    NSString *mailto = [NSString stringWithFormat:@"mailto:%@", email];
    NSURLComponents *comp = [[NSURLComponents alloc] initWithString:mailto];
    comp.queryItems = @[[NSURLQueryItem queryItemWithName:@"subject" value:subject]];
    [[UIApplication sharedApplication] openURL:comp.URL options:@{} completionHandler:nil];
}

@end
