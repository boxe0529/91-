
//
//  CateViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/27.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "CateViewController.h"
#import "cate4app.h"
#import "BJapp.h"
#import "UIView+exstion.h"
#import "detailpageViewController.h"
#import "appbox.h"
@interface CateViewController ()

@end

@implementation CateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subapplyapp=[[NSMutableArray alloc]initWithCapacity:30];
    self.applyapp=[[NSMutableArray alloc]initWithCapacity:100];
    self.subgameapp=[[NSMutableArray alloc]initWithCapacity:30];
    self.gameapp=[[NSMutableArray alloc]initWithCapacity:100];
    self.BJapp=[[NSMutableArray alloc]initWithCapacity:30];
    self.segs.selectedSegmentIndex = 0;//设置默认选择项索引
    
    NSLog(@"%ld,%ld",(long)self.seg,(long)self.indext);
    if(self.seg==0)
    {
        [self laodCATEData];
        [self laodCateDetailData];
        [self.tableView reloadData];
        
    }
    else
    {
        
       [self laodCATEgameData];
        [self laodCateDetailData];
        [self.tableView reloadData];
        
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if([self.view window]==nil)
    {
        self.view=nil;
    }
    // Dispose of any resources that can be recreated.
}
-(void)laodCATEData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/soft/phone/cat.aspx?act=213&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&pi=1&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        
        NSArray *f =free[@"Result"];
      
        [self.applyapp removeAllObjects];
  
        for( NSDictionary * df in f)
        {
            NSArray * ar=df[@"listTags"];
            //[self.applyapp removeAllObjects];
            for( NSDictionary * dict in ar)
            {
                cate4app * applyapp=[[cate4app alloc]init];
                applyapp.Url1=dict[@"url"];
                
                [self.applyapp addObject:applyapp];
               // NSLog(@"%@",applyapp.Url1);
                
            }

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
        [self.gameapp removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            NSArray * ar=df[@"listTags"];
            
            [self.subgameapp removeAllObjects];
            for( NSDictionary * dict in ar)
            {
                cate4app * applyapp=[[cate4app alloc]init];
                applyapp.Url1=dict[@"url"];
                
                [self.gameapp addObject:applyapp];
                // NSLog(@"%@",applyapp.Url1);
            }
          
        }
        //NSLog(@"%@",self.gameapp);
    }
    
}
-(void)laodCateDetailData
{
   
    if(self.seg==0)
    {
    cate4app * b=self.applyapp[self.indext*4+self.segs.selectedSegmentIndex];
        NSLog(@"%lu",(unsigned long)self.applyapp.count);
    NSURL *freeurl=[NSURL URLWithString:b.Url1];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
     {

        NSDictionary * d=free[@"Result"];

        NSArray *f =d[@"items"];
        [self.BJapp removeAllObjects];

        for( NSDictionary * df in f)
        {
            BJapp * f1=[[BJapp alloc]init];

            f1.name=df[@"name"];
            f1.imgurl=df[@"icon"];
            f1.resid=df[@"resid"];
            f1.price=df[@"price"];
            f1.originprice=df[@"originalPrice"];
            f1.sizes=[df[@"size"] integerValue];
            f1.detailurl=df[@"detailUrl"];
            f1.star=[df[@"star"] intValue ];
            f1.downtimes=df[@"downTimes"];
            [self.BJapp addObject:f1];
        
        }
     
        
     }
    }
    else
    {
        cate4app * C4=self.gameapp[self.indext*4+self.segs.selectedSegmentIndex];
        
        NSURL *freeurl=[NSURL URLWithString:C4.Url1];
        NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if(free)
        {
            //app * f1=[[app alloc]init];
            NSDictionary * d=free[@"Result"];
            // NSLog(@"%@",f);
            NSArray *f =d[@"items"];
            [self.BJapp removeAllObjects];
            //NSLog(@"%@",d[@"items"]);
            //NSLog(@"%@",f);
            for( NSDictionary * df in f)
            {
                BJapp * f1=[[BJapp alloc]init];
                // NSLog(@"%@",df[@"name"]);
                f1.name=df[@"name"];
                f1.imgurl=df[@"icon"];
                f1.resid=df[@"resid"];
                f1.price=df[@"price"];
                f1.originprice=df[@"originalPrice"];
                f1.sizes=[df[@"size"] integerValue];
                f1.detailurl=df[@"detailUrl"];
                f1.star=[df[@"star"] intValue ];
                f1.downtimes=df[@"downTimes"];
                [self.BJapp addObject:f1];
                //NSLog(@"%@",f1);
            }
            //[self.tableView reloadData];
            //[self.sectionapp addObject:f1];
            
        }

    }
    //NSLog(@"%@",self.sectionapp);
    // [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.BJapp.count;
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
    
    
    BJapp * aoo=self.BJapp[indexPath.row];
    //NSLog(@"%@", aoo.name);
    
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake((self.view.widhth-232)/5, 5, 58, 58);
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:18];
    NSURL*url=[NSURL URLWithString:aoo.imgurl];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [btn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    [cell addSubview:btn];
    UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5+68, 5, self.view.widhth/2, 22)];
    name.textColor=[UIColor blackColor];
    name.text=aoo.name;
    [name setFont:[UIFont systemFontOfSize:16]];
    [cell addSubview:name];
    for(int b=0;b<aoo.star;b++)
    {
        UIImageView *star=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detail_star.png"]];
        star.frame=CGRectMake((self.view.widhth-232)/5+68+15*b, 30, 12, 10);
        [cell addSubview:star];
    }
    UILabel *lnum=[[UILabel alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5+68, 42, 100, 16)];
    lnum.text=[NSString stringWithFormat:@"%@次下载" ,aoo.downtimes];
    [lnum setFont:[UIFont systemFontOfSize:14]];
    [lnum setTextColor:[UIColor lightGrayColor]];
    [cell addSubview:lnum];
    UILabel *size=[[UILabel alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5+68+105, 42, 100, 16)];
    float a= aoo.sizes/(1024*1024);
    size.text=[NSString stringWithFormat:@"%.2fMB",a];
    // NSLog(@"%@",size.text);
    [size setFont:[UIFont systemFontOfSize:14]];
    [size setTextColor:[UIColor lightGrayColor]];
    [cell addSubview:size];
    if(self.segs.selectedSegmentIndex==3)
    {
       
        UILabel * nowprice=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 30, 65, 30)];
        nowprice.text=[NSString stringWithFormat:@"$%@" ,aoo.price];
        [cell addSubview:nowprice];

    }
  else
    {
        UIButton * freeb=[[UIButton alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 30, 65, 30)];
        [freeb.layer setMasksToBounds:YES];
        [freeb.layer setCornerRadius:5];
        freeb.backgroundColor=[UIColor orangeColor];
        [freeb setTitle:@"免费" forState:UIControlStateNormal];
        [cell addSubview:freeb];

    }
    if(aoo.originprice >aoo.price)
    {
        UILabel *originprice=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 15, 65, 15)];
        originprice.text=[NSString stringWithFormat:@"¥%@",aoo.originprice];
        originprice.textColor=[UIColor lightGrayColor];
        [originprice setFont:[UIFont systemFontOfSize:12]];
        UILabel * open=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 15+7.5, 35, 1)];
        open.backgroundColor=[UIColor redColor];
        [cell addSubview:originprice];
        [cell addSubview:open];
    }

  UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
  cell.selectedBackgroundView = backView;
  cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
//取消边框线
 
   [cell setBackgroundView:[[UIView alloc] init]];
   cell.backgroundColor = [UIColor clearColor];



    return cell;

}

- (IBAction)segsment:(id)sender
{
    [self laodCateDetailData];
    [self.tableView reloadData];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailpageViewController * de=[[detailpageViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    appbox * a=self.BJapp[indexPath.row];
    de.detailUrl=a.detailurl;

}

@end
