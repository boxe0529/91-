//
//  MoreTwoTableViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/27.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "MoreTwoTableViewController.h"
#import "LBapp.h"
#import "UIView+exstion.h"
#import "TwoTBTableViewController.h"
@interface MoreTwoTableViewController ()

@end

@implementation MoreTwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.Name;
    self.LBMore=[[NSMutableArray alloc]initWithCapacity:30];
    self.tableView.showsVerticalScrollIndicator=NO;
    [self laodLBData];
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if([self.view window]==nil)
    {
        self.view=nil;
    }
    // Dispose of any resources that can be recreated.
}
-(void)laodLBData
{
    
    NSURL *freeurl=[NSURL URLWithString:self.detailUrl];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        //NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =free[@"Result"];
        [self.LBMore removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            LBapp * f1=[[LBapp alloc]init];
            // NSLog(@"%@",df[@"name"]);
            f1.name=df[@"name"];
            f1.icon=df[@"icon"];
            f1.act=df[@"act"];
            NSLog(@"%@---%@",f1.name,f1.act);
            [self.LBMore addObject:f1];
            //NSLog(@"%@",f1);
        }
    
        //[self.tableView reloadData];
        //[self.sectionapp addObject:f1];
        
    }
    //NSLog(@"%@",self.sectionapp);
    // [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.LBMore.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"meetingCell";
    
    UITableViewCell *cell ;
    cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    for(UIView *view in cell.subviews)
    {
        [view removeFromSuperview];
    }
    for(UILabel *l1 in cell.subviews)
    {
        [l1 removeFromSuperview];
    }
    for(UIButton *l1 in cell.subviews)
    {
        [l1 removeFromSuperview];
    }
    for(UIImageView *l1 in cell.subviews)
    {
        [l1 removeFromSuperview];
    }
    for(UIScrollView *l1 in cell.subviews)
    {
        [l1 removeFromSuperview];
    }
    for(UIPageControl *l1 in cell.subviews)
    {
        [l1 removeFromSuperview];
    }
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    LBapp * aoo=self.LBMore[indexPath.row];
    //NSLog(@"%@", aoo.name);
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake((self.view.widhth-232)/5, 5, 58, 58);
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:18];
    NSURL*url=[NSURL URLWithString:aoo.icon];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [btn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    [cell addSubview:btn];
    
    UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5+78, 20, 150, 40)];
    name.text=aoo.name;
    [cell addSubview:name];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwoTBTableViewController * moretwo=[[TwoTBTableViewController alloc]init];
    [self.navigationController pushViewController:moretwo animated:YES];
    LBapp * a=self.LBMore[indexPath.row];
    moretwo.detailUrl=a.act;
    moretwo.Name=a.name;
    
}
@end
