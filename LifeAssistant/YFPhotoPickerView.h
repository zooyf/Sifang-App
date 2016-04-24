//
//  PhotoPickerView.h
//  SelectPhotoDemo
//
//  Created by YesterdayFinder on 15/12/6.
//  Copyright © 2015年 YesterdayFinder. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YFPhotoPickerViewDelegate <NSObject>

@optional

/**
 *  返回选中的图片
 *
 *  @param selectedImage 选中的图片
 */
- (void)photoPickerSavedInDefaults:(UIImage *)selectedImage;

@end

@interface YFPhotoPickerView : UIImageView<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) id<YFPhotoPickerViewDelegate> delegate;

/**
 *  是否剪切
 */
@property (nonatomic, assign, getter=isAllowedEditing) BOOL allowsEditing;

@property(nonatomic, strong) NSData *compressedData;

- (NSData *)compressImage:(UIImage *)image withQuality:(CGFloat)quality;

@end
