//
//  TabBarController.m
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "TabBarController.h"
#import "OneTableViewController.h"
#import "TwoTableViewController.h"
#import "ThreeTableViewController.h"
#import "FourViewController.h"
#import "NavViewController.h"
#import "tabbar.h"
#import "SVProgressHUD.h"
@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    OneTableViewController * homevc=[[OneTableViewController alloc]init];
    [self addwithchildvc:homevc title:@"首页" imgName:@"homepage_home" imgselectedName:@"homepage_home_sel"];
    
    
    TwoTableViewController * messageVC=[[TwoTableViewController alloc]init];
    [self addwithchildvc:messageVC title:@"聊吧" imgName:@"homepage_talk" imgselectedName:@"homepage_talk_sel"];
    
    
    ThreeTableViewController * disVC=[[ThreeTableViewController alloc]init];
    [self addwithchildvc:disVC title:@"分类" imgName:@"homepage_cate" imgselectedName:@"homepage_cate_sel"];
    
    
    FourViewController * profileVC=[[FourViewController alloc]init];
    [self addwithchildvc:profileVC title:@"搜索" imgName:@"homepage_seach" imgselectedName:@"homepage_seach_sel"];
    
    //tabbar * Tabb=[[tabbar alloc]init];
    //self.tabBar=Tabb;//kvc
    //[self setValue:Tabb forKey:@"tabBar"];
}
-(void)addwithchildvc:(UIViewController *)childvc title:(NSString *)title imgName:(NSString*)imgName imgselectedName:(NSString *)imgSelectedName
{
    //childvc.tabBarItem.title=title;
    //childvc.navigationItem.title=title;
    
    childvc.title=title;
    //修改字体的颜色
    NSMutableDictionary * arr=[[NSMutableDictionary alloc]init];
    arr[NSForegroundColorAttributeName]=[UIColor orangeColor];
    
    NSMutableDictionary * arr2=[[NSMutableDictionary alloc]init];
    arr2[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    
    [childvc.tabBarItem setTitleTextAttributes:arr2 forState:UIControlStateNormal];
    [childvc.tabBarItem setTitleTextAttributes:arr forState:UIControlStateSelected];
    
    UIImage * img=[UIImage imageNamed:imgSelectedName];
    //阻止tab控制器渲染图片
    img=[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childvc.tabBarItem.selectedImage=img;
    childvc.tabBarItem.image=[UIImage imageNamed:imgName];
    
    NavViewController * nav=[[NavViewController alloc]initWithRootViewController:childvc];
    [self addChildViewController:nav];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
