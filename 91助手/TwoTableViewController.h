//
//  TwoTableViewController.h
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray * LBapp;
@end
