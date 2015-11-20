//
//  detailpageViewController.h
//  91助手
//
//  Created by 邓云方 on 15/10/23.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailpageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *require;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)downlaodapp:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scroview2;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UIButton *free;
@property (weak, nonatomic) IBOutlet UITextView *intro;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIButton *b1;
@property (weak, nonatomic) IBOutlet UILabel *downlaod;
@property (weak, nonatomic) IBOutlet UIButton *b2;
@property (weak, nonatomic) IBOutlet UIButton *b3;
@property (weak, nonatomic) IBOutlet UIButton *b4;
@property (weak, nonatomic) IBOutlet UILabel *jianrongxing;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *datename;
@property (weak, nonatomic) IBOutlet UILabel *lan;
@property (weak, nonatomic) IBOutlet UILabel *updatetime;

@property (strong ,nonatomic)NSString * detailUrl;
@property (strong ,nonatomic)NSMutableArray * detailapp;
@property (strong ,nonatomic)NSMutableArray * addapp;
@property (retain ,nonatomic)NSMutableData * pData;
- (void)UesrClicked:(UITapGestureRecognizer *)recognizer;
@end
