//
//  PHAsset+LKUtils.m
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import "PHAsset+LKKit.h"

@implementation PHAsset (LKKit)

+ (nullable instancetype)lk_assetWithId:(NSString *)idStr
{
    if (!idStr.length) {
        return nil;
    }
    
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsWithLocalIdentifiers:@[idStr] options:nil];
    return result.firstObject;
}

- (void)lk_fetchImageDataWithCallback:(LKNSDataBlock)callback
{
    PHImageRequestOptions *op = [PHImageRequestOptions new];
    op.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    op.resizeMode = PHImageRequestOptionsResizeModeNone;
    op.networkAccessAllowed = YES;
    
    [[PHImageManager defaultManager] requestImageDataForAsset:self
                                                      options:op
                                                resultHandler:
     ^(NSData * _Nullable imageData, NSString * _Nullable dataUTI,
       UIImageOrientation orientation, NSDictionary * _Nullable info) {
        lk_async_on_main_queue(^{
            LK_SAFE_BLOCK(callback, imageData);
        });
    }];
}

- (void)lk_deleteAssetWithCallback:(LKBOOLBlock)callback
{
    [PHAsset lk_deleteAssets:@[self] callback:callback];
}

+ (void)lk_deleteAssets:(NSArray<PHAsset *> *)assets callback:(LKBOOLBlock)callback
{
    if (!assets.count) {
        LK_SAFE_BLOCK(callback, NO);
        return;
    }
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest deleteAssets:assets];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        lk_async_on_main_queue(^{
            LK_SAFE_BLOCK(callback, success);
        });
    }];
}

@end
