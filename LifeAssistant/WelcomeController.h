//
//  WelcomeController.h
//  Guru
//
//  Created by pengfei on 16/4/15.
//  Copyright © 2016年 com.techwolf.guru. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginController.h"
#import "RegController.h"

@interface WelcomeController : BaseViewController

@property (nonatomic, strong) LoginController *login;
@property(nonatomic, strong) RegController *reg;


@end
