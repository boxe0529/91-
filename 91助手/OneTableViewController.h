//
//  OneTableViewController.h
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneTableViewController : UITableViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)  UIScrollView *scrollview;
@property (strong, nonatomic)  UIPageControl *pagecontrol;
@property (strong, nonatomic) UITableView *tableview;
@property(strong,nonatomic) NSMutableArray * sectionapp;
@property(strong,nonatomic) NSMutableArray * jpapp;
@property(strong,nonatomic) NSMutableArray * ZTapp;
@property(strong,nonatomic) NSMutableArray * HMapp;
@property(strong,nonatomic) NSMutableArray * BJapp;
@end
