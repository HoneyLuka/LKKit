//
//  LKDeviceHelper.h
//  LKImageInfoViewer
//
//  Created by Luka Li on 28/5/2020.
//  Copyright © 2020 Luka Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void(^LKPhotoAuthorizationCallback)(PHAuthorizationStatus status, BOOL isAllowed);

@interface LKDeviceHelper : NSObject

+ (BOOL)isiPad;
+ (BOOL)isiPhone;

+ (CGSize)screenSize;

+ (UIEdgeInsets)safeAreaInsets;

/// check if photo Authorization is authorized, both Authorized and Limited are authorized.
+ (BOOL)isPhotoAuthorized;
+ (void)requestPhotoAuthorization:(LKPhotoAuthorizationCallback)callback;

+ (void)openAppSettings;

+ (NSString *)bundleId;
+ (NSString *)appName;
+ (NSString *)appVersion;
+ (NSString *)appBuildNumber;

+ (void)feedbackTo:(NSString *)email;

@end
