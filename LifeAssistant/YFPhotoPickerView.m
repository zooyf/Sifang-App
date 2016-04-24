//
//  PhotoPickerView.m
//  SelectPhotoDemo
//
//  Created by YesterdayFinder on 15/12/6.
//  Copyright © 2015年 YesterdayFinder. All rights reserved.
//

#import "YFPhotoPickerView.h"

@interface YFPhotoPickerView ()
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@end

@implementation YFPhotoPickerView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *takePictureAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *choosePhotoAction = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    [alertSheet addAction:cancelAction];
    [alertSheet addAction:takePictureAction];
    [alertSheet addAction:choosePhotoAction];
    
    UIViewController *topVC = [[UIApplication sharedApplication] topViewController];
    
    [topVC presentViewController:alertSheet animated:YES completion:nil];

}


- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = self.isAllowedEditing;
    
    UIViewController *topVC = [[UIApplication sharedApplication] topViewController];
    
    [topVC presentViewController:imagePickerController animated:YES completion:nil];
    
}

- (NSData *)compressImage:(UIImage *)image withQuality:(CGFloat)quality {
    return UIImageJPEGRepresentation(image, quality);
}


#pragma mark -- UIImagePickerControllerDelegate --

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *selectedImage = nil;
    if (_allowsEditing) {
        selectedImage = [info valueForKey:UIImagePickerControllerEditedImage];
    } else {
        selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    
    self.compressedData = UIImageJPEGRepresentation(selectedImage, 0.0);
    selectedImage = [UIImage imageWithData:self.compressedData];
    
    [self setImage:selectedImage];
    
    if ([self.delegate respondsToSelector:@selector(photoPickerSavedInDefaults:)]) {
        [self.delegate photoPickerSavedInDefaults:selectedImage];
    }
    
    // 照相机照片写入相册
    if ( picker.sourceType == UIImagePickerControllerSourceTypeCamera ) {
        UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(originalImage, nil, nil, nil);
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc {
    self.delegate = nil;
}

@end
