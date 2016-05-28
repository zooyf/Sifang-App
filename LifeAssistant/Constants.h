//
//  Constants.h
//  LifeAssistant
//
//  Created by YesterdayFinder on 16/4/19.
//  Copyright © 2016年 zooyf. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kFMListToDetailSegue @"FMListToDetailSegue"

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

#define kTabBarHeight 50
#define kNavigationBarHeight 64

#define kWEAK __weak typeof(self) weakSelf = self;

#define theApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/**
 调用一个block,会判断block不为空
 */
#define BlockCallWithVoidArg(block)  if(block){block();}

/**
 调用一个block,会判断block不为空
 */
#define BlockCallWithOneArg(block,arg)  if(block){block(arg);}
/**
 调用一个block,会判断block不为空
 */
#define BlockCallWithTwoArg(block,arg1,arg2) if(block){block(arg1,arg2);}
/**
 调用一个block,会判断block不为空
 */
#define BlockCallWithThreeArg(block,arg1,arg2,arg3) if(block){block(arg1,arg2,arg3);}


#endif /* Constants_h */
