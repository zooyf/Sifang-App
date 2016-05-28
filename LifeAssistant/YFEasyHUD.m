//
//  YFEasyHUD.m
//  BabyWatcher
//
//  Created by YesterdayFinder on 16/2/21.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import "YFEasyHUD.h"
#import <MBProgressHUD.h>


static MBProgressHUD *_hud;

@implementation YFEasyHUD

+ (void)showMsg:(NSString *)msg details:(NSString *)details lastTime:(NSTimeInterval)delay {
    [_hud hide:YES];
    _hud = nil;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[YFUtils topView] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.detailsLabelText = details;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
}

+ (void)showMsg:(NSString *)msg {
    [_hud hide:YES];
    _hud = nil;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[YFUtils topView] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    _hud = hud;
}

+ (void)hideHud {
    [_hud hide:YES];
    _hud = nil;
}

@end
