//
//  ThreeTableViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "ThreeTableViewController.h"
#import "UIView+exstion.h"
#import "CateApp.h"
#import "CateViewController.h"
#import "MJRefresh.h"
@interface ThreeTableViewController ()
{
    UISegmentedControl *segmentedControl;
}
@end

@implementation ThreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=nil;
    self.tableView.showsVerticalScrollIndicator=NO;
     [self.tableView addHeaderWithTarget:self action:@selector(head:)];
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"应用",@"游戏",nil];
   //初始化UISegmentedControl
       segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        segmentedControl.frame = CGRectMake(0, 0, 150, 30.0);
        segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
        segmentedControl.tintColor = [UIColor redColor];
    [segmentedControl addTarget:self action:@selector(changetap:) forControlEvents:UIControlEventValueChanged];
   
    
    self.navigationItem.titleView=segmentedControl;
    
    self.CateAPP =[[NSMutableArray alloc]initWithCapacity:30];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self laodCATEData];
    [self.tableView reloadData];
 
}

-(void)head:(id)sender
{
    if( [segmentedControl selectedSegmentIndex]==0)
    {
        [self laodCATEData];
        [self.tableView reloadData];
    }
    else
    {
        [self laodCATEgameData];
        [self.tableView reloadData];
    }
    [self.tableView headerEndRefreshing];
}

-(void)changetap:(UISegmentedControl*)sender
{
    if( [segmentedControl selectedSegmentIndex]==0)
    {
        [self laodCATEData];
        [self.tableView reloadData];
    }
    else
    {
        [self laodCATEgameData];
        [self.tableView reloadData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if([self.view window]==nil)
    {
        self.view=nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.CateAPP.count;
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
    
    CateApp * aoo=self.CateAPP[indexPath.row];
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
    
    UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5+68, 5, 150, 40)];
    name.text=aoo.name;
    [cell addSubview:name];
    
    UILabel * subname=[[UILabel alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5+68, 35, 250, 35)];
    subname.text=aoo.summary;
    [subname setTextColor:[UIColor lightGrayColor]];
    [subname setFont:[UIFont systemFontOfSize:13]];
    [cell addSubview:subname];
    return cell;
}
-(void)laodCATEData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=213&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&pi=1&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        //NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =free[@"Result"];
        [self.CateAPP removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            CateApp * f1=[[CateApp alloc]init];
            // NSLog(@"%@",df[@"name"]);
            f1.name=df[@"name"];
            f1.icon=df[@"icon"];
            f1.summary=df[@"summary"];
            
            [self.CateAPP addObject:f1];
            //NSLog(@"%@",f1);
        }
     
    }
   
}
-(void)laodCATEgameData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=218&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&pi=1&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        //NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =free[@"Result"];
        [self.CateAPP removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            CateApp * f1=[[CateApp alloc]init];
            // NSLog(@"%@",df[@"name"]);
            f1.name=df[@"name"];
            f1.icon=df[@"icon"];
            f1.summary=df[@"summary"];
            
            [self.CateAPP addObject:f1];
            //NSLog(@"%@",f1);
        }
        
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CateViewController * cate=[[CateViewController alloc]init];
    [self.navigationController pushViewController:cate animated:YES];
    cate.seg= segmentedControl.selectedSegmentIndex;
    cate.indext=indexPath.row;
    
}
@end
