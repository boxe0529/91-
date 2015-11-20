//
//  TwoTableViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "TwoTableViewController.h"
#import "LBapp.h"
#import "UIView+exstion.h"
#import "MoreTwoTableViewController.h"
#import "MJRefresh.h"
@interface TwoTableViewController ()

@end

@implementation TwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"聊吧";
    self.LBapp=[[NSMutableArray alloc]initWithCapacity:30];
    self.tableView.showsVerticalScrollIndicator=NO;
    [self laodLBData];
    [self.tableView reloadData];
     [self.tableView addHeaderWithTarget:self action:@selector(head:)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)head:(id)sender
{
    [self laodLBData];
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.LBapp.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"感兴趣的贴吧";
}
/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
    return 80.0;
    }
    return 80;
}*/
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
    
    LBapp * aoo=self.LBapp[indexPath.row];
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
-(void)laodLBData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/api/?act=702&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        //NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =free[@"Result"];
        [self.LBapp removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            LBapp * f1=[[LBapp alloc]init];
            // NSLog(@"%@",df[@"name"]);
            f1.name=df[@"name"];
            f1.icon=df[@"icon"];
            f1.act=df[@"act"];
            
            [self.LBapp addObject:f1];
            //NSLog(@"%@",f1);
        }
        //[self.tableView reloadData];
        //[self.sectionapp addObject:f1];
        
    }
    //NSLog(@"%@",self.sectionapp);
    // [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTwoTableViewController * moretwo=[[MoreTwoTableViewController alloc]init];
    [self.navigationController pushViewController:moretwo animated:YES];
    LBapp * a=self.LBapp[indexPath.row];
    moretwo.detailUrl=a.act;
    moretwo.Name=a.name;

}


@end
