//
//  CateViewController.h
//  91助手
//
//  Created by 邓云方 on 15/10/27.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong ,nonatomic)NSMutableArray * applyapp;
@property (strong ,nonatomic)NSMutableArray * gameapp;
- (IBAction)segsment:(id)sender;
@property (strong ,nonatomic)NSMutableArray * subapplyapp;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segs;
@property (strong ,nonatomic)NSMutableArray * subgameapp;
@property(assign,nonatomic)NSInteger seg;
@property(assign,nonatomic)NSInteger indext;
@property (strong ,nonatomic)NSMutableArray * BJapp;
@end
