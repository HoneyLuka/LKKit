//
//  LKAppearance.m
//  LKKit
//
//  Created by Selina on 29/12/2020.
//

#import "LKAppearance.h"
#import <LKFoundation/LKFoundation.h>
#import "LKKitDefines.h"
#import "UIColor+LKKit.h"
#import <objc/runtime.h>

NSString * const LKAppearanceLightKey = @"light";
NSString * const LKAppearanceDarkKey = @"dark";

@interface LKAppearance ()

@property (nonatomic, strong) UIColor *themeColor;

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *secondaryBgColor;
@property (nonatomic, strong) UIColor *tertiaryBgColor;

@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIColor *secondaryLabelColor;
@property (nonatomic, strong) UIColor *tertiaryLabelColor;

@property (nonatomic, strong) UIColor *placeholderTextColor;

@property (nonatomic, strong) UIColor *infoColor;
@property (nonatomic, strong) UIColor *successColor;
@property (nonatomic, strong) UIColor *errorColor;

@end

@implementation LKAppearance

#pragma mark - Public

+ (void)configWithAppearanceData:(NSData *)data
{
    [[LKAppearance sharedAppearance] configWithData:data];
}

+ (UIColor *)themeColor
{
    return [LKAppearance sharedAppearance].themeColor;
}

+ (UIColor *)bgColor
{
    return [LKAppearance sharedAppearance].bgColor;
}

+ (UIColor *)secondaryBgColor
{
    return [LKAppearance sharedAppearance].secondaryBgColor;
}

+ (UIColor *)tertiaryBgColor
{
    return [LKAppearance sharedAppearance].tertiaryBgColor;
}

+ (UIColor *)labelColor
{
    return [LKAppearance sharedAppearance].labelColor;
}

+ (UIColor *)secondaryLabelColor
{
    return [LKAppearance sharedAppearance].secondaryLabelColor;
}

+ (UIColor *)tertiaryLabelColor
{
    return [LKAppearance sharedAppearance].tertiaryLabelColor;
}

+ (UIColor *)placeholderTextColor
{
    return [LKAppearance sharedAppearance].placeholderTextColor;
}

+ (UIColor *)infoColor
{
    return [LKAppearance sharedAppearance].infoColor;
}

+ (UIColor *)successColor
{
    return [LKAppearance sharedAppearance].successColor;
}

+ (UIColor *)errorColor
{
    return [LKAppearance sharedAppearance].errorColor;
}

#pragma mark - Private

+ (void)load
{
    [LKAppearance sharedAppearance];
}

+ (instancetype)sharedAppearance
{
    static LKAppearance *sAppearance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sAppearance = [LKAppearance new];
    });
    
    return sAppearance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaultValues];
        [self configWithData:nil];
    }
    return self;
}

- (void)initDefaultValues
{
    self.themeColor = UIColor.systemBlueColor;
    
    self.bgColor = UIColor.systemBackgroundColor;
    self.secondaryBgColor = UIColor.secondarySystemBackgroundColor;
    self.tertiaryBgColor = UIColor.tertiarySystemBackgroundColor;
    
    self.labelColor = UIColor.labelColor;
    self.secondaryLabelColor = UIColor.secondaryLabelColor;
    self.tertiaryLabelColor = UIColor.tertiaryLabelColor;
    
    self.placeholderTextColor = UIColor.placeholderTextColor;
    
    self.infoColor = UIColor.systemGrayColor;
    self.successColor = UIColor.systemGreenColor;
    self.errorColor = UIColor.systemRedColor;
}

- (void)configWithData:(NSData *)data
{
    if (!data.length) {
        // load from bundle
        data = [self loadDataFromBundle];
    }
    
    if (!data.length) {
        return;
    }
    
    NSError *error;
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        LKKitLogWarning(@"color data parsing failed");
        return;
    }
    
    NSDictionary *light = root[LKAppearanceLightKey];
    NSDictionary *dark = root[LKAppearanceDarkKey];
    
    uint count = 0;
    Ivar *list = class_copyIvarList(self.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = list[i];
        const char *name = ivar_getName(ivar);
        NSString *nameStr = [NSString stringWithUTF8String:name];
        NSString *key = [nameStr substringFromIndex:1];
        UIColor *lightColor = LK_COLOR_HEX(light[key]);
        UIColor *darkColor = LK_COLOR_HEX(dark[key]);
        
        if (!lightColor || !darkColor) {
            continue;
        }
        
        UIColor *dynamicColor = [UIColor lk_lightColor:lightColor darkColor:darkColor];
        object_setIvar(self, ivar, dynamicColor);
    }
}

#pragma mark - Helper

- (NSData *)loadDataFromBundle
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"app_appearance" ofType:@"json"];
    if (!path.length) {
        LKKitLogWarning(@"app_color.json file is missing");
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data.length) {
        LKKitLogWarning(@"app_color.json file loading failed");
        return nil;
    }
    
    return data;
}

@end
