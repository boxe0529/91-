//
//  MoreTableViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/24.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "MoreTableViewController.h"
#import "appbox.h"
#import "detailpageViewController.h"

@interface MoreTableViewController ()

@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",self.detailUrl);
    self.title=self.Name;
    self.ZTMore=[[NSMutableArray alloc]initWithCapacity:20];
    self.tableView.showsVerticalScrollIndicator=NO;
    [self laodData];
    [self.tableView reloadData];
    
    
}
-(void)laodData
{
    
    NSURL *freeurl=[NSURL URLWithString:self.detailUrl];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@",free);
    if(free)
    {
        //app * f1=[[app alloc]init];
        NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =d[@"items"];
        [self.ZTMore removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            appbox * f1=[[appbox alloc]init];
            // NSLog(@"%@",df[@"name"]);
            f1.name=df[@"name"];
            f1.imgurl=df[@"icon"];
            f1.resid=df[@"resid"];
            f1.price=df[@"price"];
            f1.originprice=df[@"originalPrice"];
            f1.sizes=[df[@"size"] integerValue];
            
            f1.star=[df[@"star"] intValue ];
            f1.downtimes=df[@"downTimes"];
         
            f1.detailurl=df[@"detailUrl"];
          
            [self.ZTMore addObject:f1];
            // NSLog(@"%@",f1);
        }

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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.ZTMore.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
   
    appbox * aoo=self.ZTMore[indexPath.row];
    //NSLog(@"%@", aoo.name);
    int ab=[UIScreen mainScreen].bounds.size.width;
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake((ab-232)/5, 5, 58, 58);
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:18];
    NSURL*url=[NSURL URLWithString:aoo.imgurl];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [btn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    [cell addSubview:btn];
    UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake((ab-232)/5+68, 5, ab/2, 22)];
    name.textColor=[UIColor blackColor];
    name.text=aoo.name;
    [name setFont:[UIFont systemFontOfSize:16]];
    [cell addSubview:name];
    for(int b=0;b<aoo.star;b++)
    {
        UIImageView *star=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detail_star.png"]];
        star.frame=CGRectMake((ab-232)/5+68+15*b, 30, 12, 10);
        [cell addSubview:star];
    }
    UILabel *lnum=[[UILabel alloc]initWithFrame:CGRectMake((ab-232)/5+68, 42, 100, 16)];
    lnum.text=[NSString stringWithFormat:@"%@次下载" ,aoo.downtimes];
    [lnum setFont:[UIFont systemFontOfSize:14]];
    [lnum setTextColor:[UIColor lightGrayColor]];
    [cell addSubview:lnum];
    UILabel *size=[[UILabel alloc]initWithFrame:CGRectMake((ab-232)/5+68+105, 42, 100, 16)];
    float a= aoo.sizes/(1024*1024);
    size.text=[NSString stringWithFormat:@"%.2fMB",a];
    // NSLog(@"%@",size.text);
    [size setFont:[UIFont systemFontOfSize:14]];
    [size setTextColor:[UIColor lightGrayColor]];
    [cell addSubview:size];
    if([aoo.price floatValue]==0)
    {
        UIButton * freeb=[[UIButton alloc]initWithFrame:CGRectMake(ab-(ab-232)/5-65, 30, 65, 30)];
        [freeb.layer setMasksToBounds:YES];
        [freeb.layer setCornerRadius:5];
        freeb.backgroundColor=[UIColor orangeColor];
        [freeb setTitle:@"免费" forState:UIControlStateNormal];
        
        
        [cell addSubview:freeb];
    }
    else
    {
        UILabel * nowprice=[[UILabel alloc]initWithFrame:CGRectMake(ab-(ab-232)/5-65, 30, 65, 30)];
        nowprice.text=[NSString stringWithFormat:@"$%@" ,aoo.price];
        [cell addSubview:nowprice];
    }
    if([aoo.originprice floatValue] >0)
    {
        UILabel *originprice=[[UILabel alloc]initWithFrame:CGRectMake(ab-(ab-232)/5-65, 15, 65, 15)];
        originprice.text=[NSString stringWithFormat:@"¥%@",aoo.originprice];
        originprice.textColor=[UIColor lightGrayColor];
        [originprice setFont:[UIFont systemFontOfSize:12]];
        UILabel * open=[[UILabel alloc]initWithFrame:CGRectMake(ab-(ab-232)/5-65, 15+7.5, 65, 1)];
        open.backgroundColor=[UIColor redColor];
        [cell addSubview:originprice];
        [cell addSubview:open];
    }
    
    
    return cell;
}
//单击一个cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(cell.tag == 0)
    {
        
        
        cell.selected = NO;
    }else
    {
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    }
    
    
        detailpageViewController * de=[[detailpageViewController alloc]init];
        [self.navigationController pushViewController:de animated:YES];
        appbox * a=self.ZTMore[indexPath.row];
        de.detailUrl=a.detailurl;
        
    
}
@end
