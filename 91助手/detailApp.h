//
//  detailApp.h
//  91助手
//
//  Created by 邓云方 on 15/10/23.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface detailApp : NSObject
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *icon;
@property (strong,nonatomic)NSString * resid;
@property (assign,nonatomic)int  star;
@property (strong,nonatomic) NSString * downtimes;
@property (assign,nonatomic) long sizes;
@property (strong,nonatomic) NSString * price;
@property (strong,nonatomic) NSString * originprice;

@property (strong,nonatomic) NSString * downAct;
@property (strong,nonatomic) NSString * cateName;
@property (strong,nonatomic) NSString * desc;
@property (strong,nonatomic) NSString * author;
@property (strong,nonatomic) NSString * versionName;
@property (strong,nonatomic) NSString * requirement;
@property (strong,nonatomic) NSString * lan;
@property (strong,nonatomic) NSString * updatetime;
@property (strong,nonatomic) NSArray * imgs;
@end
