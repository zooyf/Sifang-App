//
//  YFUtils.m
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/5/27.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#import "YFUtils.h"
#import "MYInfoController.h"

@implementation YFUtils

+ (UIView *)topView {
    return [self topController].view;
}

+ (UIViewController*)topController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+ (UIViewController *)infoController {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MYInfoController *info = [mainStoryboard instantiateViewControllerWithIdentifier:kMYInfoController];
    info.afterReg = YES;
    info.hidesBottomBarWhenPushed = YES;
    return info;
}

@end
