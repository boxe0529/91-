//
//  app.h
//  91助手
//
//  Created by 邓云方 on 15/10/22.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface app : NSObject
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *imgurl;
@property (strong,nonatomic)NSString * resid;
@property (assign,nonatomic)int  star;
@property (strong,nonatomic) NSString * downtimes;
@property (assign,nonatomic) long sizes;
@property (strong,nonatomic) NSString * price;
@property (strong,nonatomic) NSString * originprice;
@property (strong,nonatomic) NSString * detailurl;
@property (strong,nonatomic) NSString * downAct;
@property (strong,nonatomic) NSString * cateName;
@property (strong,nonatomic) NSString * summary;
@property (strong,nonatomic) NSString * author;
@end
