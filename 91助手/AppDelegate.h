//
//  AppDelegate.h
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic) FMDatabase * db;
@end

