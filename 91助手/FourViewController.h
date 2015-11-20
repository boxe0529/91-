//
//  FourViewController.h
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    UITextField * txt;
}
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)delhistory:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *l1;
@property (weak, nonatomic) IBOutlet UILabel *l2;
@property (weak, nonatomic) IBOutlet UILabel *l3;
@property (weak, nonatomic) IBOutlet UILabel *l4;
@property (weak, nonatomic) IBOutlet UILabel *l5;
@property (weak, nonatomic) IBOutlet UILabel *l6;
@property (weak, nonatomic) IBOutlet UILabel *l7;
@property (weak, nonatomic) IBOutlet UILabel *l8;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *l9;
@property (weak, nonatomic) IBOutlet UILabel *searchrecord;
@property (strong,nonatomic) NSMutableArray *  records;
@property (strong,nonatomic) NSMutableArray *  HMapp;
@end
