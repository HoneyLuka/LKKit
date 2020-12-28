//
//  PHAsset+LKUtils.h
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import <Photos/Photos.h>
#import <LKFoundation/LKFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (LKKit)

+ (nullable instancetype)lk_assetWithId:(NSString *)idStr;

- (void)lk_fetchImageDataWithCallback:(LKNSDataBlock)callback;
- (void)lk_deleteAssetWithCallback:(LKBOOLBlock)callback;

+ (void)lk_deleteAssets:(NSArray<PHAsset *> *)assets callback:(LKBOOLBlock)callback;

@end

NS_ASSUME_NONNULL_END
