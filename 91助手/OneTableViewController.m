//
//  OneTableViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "OneTableViewController.h"
#import "UIView+exstion.h"
#import "app.h"
#import "appbox.h"
#import "ZTapp.h"
#import "HMapp.h"
#import "MJRefresh.h"
#import "BJapp.h"
#import "Reachability.h"
#import  "detailpageViewController.h"
#import "MoreTableViewController.h"
#import "MJRefresh.h"
@interface OneTableViewController ()

@end

@implementation OneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title=@"91助手";
     [self.tableView addHeaderWithTarget:self action:@selector(head:)];
    Reachability *Reach=[Reachability reachabilityForInternetConnection];
    NetworkStatus status= [Reach currentReachabilityStatus];
    if(status==NotReachable)
    {
        //[SVProgressHUD showErrorWithStatus:@"无网络连接，请检查网络设置"];
        UIAlertView * aler=[[UIAlertView alloc]initWithTitle:@"" message:@"无网络连接，请检查网络设置" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [aler show];
        return ;
    }
    self.tableView.showsVerticalScrollIndicator=NO;
    self.sectionapp =[[NSMutableArray alloc]initWithCapacity:30];
    self.jpapp=[[NSMutableArray alloc]initWithCapacity:30];
    self.ZTapp=[[NSMutableArray alloc]initWithCapacity:30];
    self.HMapp=[[NSMutableArray alloc]initWithCapacity:20];
    self.BJapp=[[NSMutableArray alloc]initWithCapacity:20];
    self.scrollview=[[UIScrollView alloc]init];
    self.pagecontrol=[[UIPageControl alloc]init];
    self.scrollview.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 175);
    self.pagecontrol.size=CGSizeMake(66, 20);
   // NSLog(@"%f",self.tableView .widhth);
    int a=[UIScreen mainScreen].bounds.size.width ;
    [self laodZTData];
    for(int i=0;i<3;i++)
    {
        ZTapp * zt=self.ZTapp[i];
        
        NSURL*url=[NSURL URLWithString:zt.icon];
        NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
       
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1:)];
        
       
       // NSString * imgname=[NSString stringWithFormat:@"aboutBg@2x.png"];
        UIImage * img=[UIImage imageWithData:data];
        UIImageView * imgview=[[UIImageView alloc]initWithImage:img];
         imgview.userInteractionEnabled=YES;
        imgview.x=0;
        imgview.x=a*i;
        imgview.widhth=a;
        imgview.highth=175;
         [imgview addGestureRecognizer:singleTap1];
        [self.scrollview addSubview:imgview];
    }
    self.scrollview.contentSize=CGSizeMake(a*3, self.scrollview.highth);
    self.scrollview.bounces=NO;
    self.scrollview.pagingEnabled=YES;
    self.scrollview.showsHorizontalScrollIndicator=FALSE;
    //self.pagecontrol=[[UIPageControl alloc]init];
    self.pagecontrol.numberOfPages=3;
    self.pagecontrol.currentPage=0;
    self.pagecontrol.currentPageIndicatorTintColor=[UIColor redColor];
    self.pagecontrol.pageIndicatorTintColor=[UIColor grayColor];
    self.pagecontrol.centerx=a*0.5-33;
    self.pagecontrol.centery=self.scrollview.highth-8;
    
    self.scrollview.delegate=self;
    self.tableView.delegate=self;
    [self laodData];
    [self laodJPData];
    
    [self laodHMData];
    [self laodBJData];
    [self.tableView reloadData];
}

-(void)head:(id)sender
{
    [self laodData];
    [self laodJPData];
    [self laodZTData];
    [self laodHMData];
    [self laodBJData];
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
}
-(void)laodData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/api/?act=236&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=15&mt=1&nt=10&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =d[@"items"];
        [self.sectionapp removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            app * f1=[[app alloc]init];
           // NSLog(@"%@",df[@"name"]);
            f1.name=df[@"name"];
            f1.imgurl=df[@"icon"];
            f1.resid=df[@"resid"];
            f1.price=df[@"price"];
            f1.originprice=df[@"originalPrice"];
            f1.sizes=[df[@"size"] integerValue];
            
            f1.star=[df[@"star"] intValue ];
            f1.downtimes=df[@"downTimes"];
            f1.author=df[@"author"];
            f1.detailurl=df[@"detailUrl"];
            f1.summary=df[@"summary"];
            f1.cateName=df[@"cateName"];
            [self.sectionapp addObject:f1];
           // NSLog(@"%@",f1);
        }
        // [self.tableView reloadData];
        //[self.sectionapp addObject:f1];
        
    }
    //NSLog(@"%@",self.sectionapp);
   // [self.tableView reloadData];
}
-(void)laodJPData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=244&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=20&mt=1&nt=10&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =d[@"items"];
        [self.jpapp removeAllObjects];
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
            f1.detailurl=df[@"detailUrl"];

            f1.originprice=df[@"originalPrice"];
            f1.sizes=[df[@"size"] integerValue];
            
            f1.star=[df[@"star"] intValue ];
            f1.downtimes=df[@"downTimes"];
            [self.jpapp addObject:f1];
            //NSLog(@"%@",f1);
        }
        //[self.tableView reloadData];
        //[self.sectionapp addObject:f1];
        
    }
    //NSLog(@"%@",self.sectionapp);
    // [self.tableView reloadData];
}
-(void)laodZTData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/soft/phone/tag.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=212&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        //NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =free[@"Result"];
        [self.ZTapp removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            ZTapp * f1=[[ZTapp alloc]init];
            // NSLog(@"%@",df[@"name"]);
            f1.name=df[@"name"];
            f1.icon=df[@"icon"];
            f1.url=df[@"url"];
            
            f1.summary=df[@"summary"];
            [self.ZTapp addObject:f1];
            //NSLog(@"%@",f1);
        }
        //[self.tableView reloadData];
        //[self.sectionapp addObject:f1];
        
    }
    //NSLog(@"%@",self.sectionapp);
    // [self.tableView reloadData];
}
-(void)laodHMData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=245&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=10&mt=1&nt=10&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =d[@"items"];
        [self.HMapp removeAllObjects];
        //NSLog(@"%@",d[@"items"]);
        //NSLog(@"%@",f);
        for( NSDictionary * df in f)
        {
            HMapp * f1=[[HMapp alloc]init];
            // NSLog(@"%@",df[@"name"]);
            f1.name=df[@"name"];
            f1.imgurl=df[@"icon"];
            f1.resid=df[@"resid"];
            f1.price=df[@"price"];
            f1.detailurl=df[@"detailUrl"];
            f1.originprice=df[@"originalPrice"];
            f1.sizes=[df[@"size"] integerValue];
            
            f1.star=[df[@"star"] intValue ];
            f1.downtimes=df[@"downTimes"];
            [self.HMapp addObject:f1];
            //NSLog(@"%@",f1);
        }
        //[self.tableView reloadData];
        //[self.sectionapp addObject:f1];
        
    }
    //NSLog(@"%@",self.sectionapp);
    // [self.tableView reloadData];
}
-(void)laodBJData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&mt=1&spid=2&osv=8.4.1&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&dm=iPhone7,2&sv=3.1.3&act=244&nt=10&pid=2&top=10"];
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
    //NSLog(@"%@",self.sectionapp);
    // [self.tableView reloadData];
}
#pragma mark - 滚动监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point=scrollView.contentOffset;
    CGFloat x=point.x;
    CGFloat pageindex=(x+self.view.widhth*0.5)/self.view.widhth;
    self.pagecontrol.currentPage=pageindex;
}

-(void)detailpage:(UIButton *)sender
{
   [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    detailpageViewController * de=[[detailpageViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    app * a=[[app alloc]init];
    for(int i=0;i<4;i++)
    {
        if(sender.frame.origin.x==((self.view.widhth-232)/5+((self.view.widhth-232)/5+58)*i))
        {
            a=self.sectionapp[i];
            de.detailUrl=a.detailurl;
        }
    }

    return;
}
-(void)buttonpress1:(UIImageView *)sender
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    ZTapp * a=[[ZTapp alloc]init];
   
            a=self.ZTapp[0];
            de.detailUrl=a.url;
            de.Name=a.name;
    
}

-(void)buttonpress2:(UIImageView *)sender
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    ZTapp * a=[[ZTapp alloc]init];
    
    a=self.ZTapp[1];
    de.detailUrl=a.url;
    de.Name=a.name;
    
}
-(void)buttonpress3:(UIImageView *)sender
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    ZTapp * a=[[ZTapp alloc]init];
    
    a=self.ZTapp[2];
    de.detailUrl=a.url;
    de.Name=a.name;
   
}
-(void)buttonpress4:(UIImageView *)sender
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    ZTapp * a=[[ZTapp alloc]init];
    
    a=self.ZTapp[3];
    de.detailUrl=a.url;
    de.Name=a.name;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if([self.view window]==nil)
    {
        self.view=nil;
    }
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(section==0)
    {
        return 1;
    }
    if(section==1)
    {
        return 1;
    }
    if(section==2)
    {
        return 5;
    }
    if(section==2)
    {
        return 5;
    }
    if(section==3)
    {
        return 1;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section>0)
    {
        return 35;
        
    }
    
    else{
        return 0;
    }
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
  
    if(indexPath.section==0 && indexPath.row==0)
    {
        [cell addSubview:self.scrollview];
        [cell addSubview:self.pagecontrol];
    }
    if(indexPath.section==1 && indexPath.row==0)
    {
        for(UIView *view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        UIView *free=[[UIView alloc]init];
        free.userInteractionEnabled=YES;
        free.backgroundColor=[UIColor orangeColor];
        for(int i=0;i<4;i++)
        {
            
            UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake((self.view.widhth-232)/5+((self.view.widhth-232)/5+58)*i, 5, 58, 58);
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:18];
            app * ap=self.sectionapp[i];
           // NSLog(@"%@",ap.name);
            NSURL*url=[NSURL URLWithString:ap.imgurl];
            NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
            NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            [btn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(detailpage:) forControlEvents:UIControlEventTouchUpInside];
            UILabel * appname=[[UILabel alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5-6+((self.view.widhth-232)/5+58)*i, 63,70, 15)];
            appname.textColor=[UIColor blackColor];
            appname.text=ap.name;
            appname.textAlignment=NSTextAlignmentCenter;
            [appname setFont:[UIFont systemFontOfSize:13]];
            
            [cell addSubview:btn];
            [cell addSubview:appname];
        }
        
    }
    if(indexPath.section==2 )
    {
       
       
        appbox * aoo=self.jpapp[indexPath.row];
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
        if([aoo.price floatValue]==0)
        {
        UIButton * freeb=[[UIButton alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 30, 65, 30)];
        [freeb.layer setMasksToBounds:YES];
        [freeb.layer setCornerRadius:5];
        freeb.backgroundColor=[UIColor orangeColor];
        [freeb setTitle:@"免费" forState:UIControlStateNormal];
        
        
        [cell addSubview:freeb];
        }
         else
         {
            UILabel * nowprice=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 30, 65, 30)];
             nowprice.text=[NSString stringWithFormat:@"$%@" ,aoo.price];
             [cell addSubview:nowprice];
         }
         if([aoo.originprice floatValue] >0)
         {
             UILabel *originprice=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 15, 65, 15)];
             originprice.text=[NSString stringWithFormat:@"¥%@",aoo.originprice];
             originprice.textColor=[UIColor lightGrayColor];
             [originprice setFont:[UIFont systemFontOfSize:12]];
             UILabel * open=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 15+7.5, 65, 1)];
             open.backgroundColor=[UIColor redColor];
             [cell addSubview:originprice];
             [cell addSubview:open];
         }
       
    
      }
    if(indexPath.section==3 && indexPath.row==0)
    {
        
        UIView *view=[[UIView alloc]init];
        view.frame=CGRectMake(0, 0, self.view.widhth, 190);
        view.userInteractionEnabled=YES;
        ZTapp * zt=self.ZTapp[0];
        UIImageView * v1=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5-10, 0, (self.view.widhth-(self.view.widhth-232)/5*2-10)/2+13, 93)];
        NSURL*url=[NSURL URLWithString:zt.icon];
        NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        v1.image=[UIImage imageWithData:data];
        v1.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1:)];
        
        [v1 addGestureRecognizer:singleTap1];
      
       
        [view addSubview:v1];
        
        zt=self.ZTapp[1];
        UIImageView * v2=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5+(self.view.widhth-(self.view.widhth-232)/5*2-10)/2+10-3, 0, (self.view.widhth-(self.view.widhth-232)/5*2-10)/2+13, 93)];
        url=[NSURL URLWithString:zt.icon];
        request=[[NSURLRequest alloc]initWithURL:url];
        data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        v2.image=[UIImage imageWithData:data];
        v2.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress2:)];
        [v2 addGestureRecognizer:singleTap2];
        [view addSubview:v2];
        
        zt=self.ZTapp[2];
        UIImageView * v3=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5-10, 100-3, (self.view.widhth-(self.view.widhth-232)/5*2-10)/2+13, 93)];
        url=[NSURL URLWithString:zt.icon];
        request=[[NSURLRequest alloc]initWithURL:url];
        data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        v3.image=[UIImage imageWithData:data];
        v3.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress3:)];
        [v3 addGestureRecognizer:singleTap3];
        [view addSubview:v3];
        
        zt=self.ZTapp[3];
        UIImageView * v4=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.widhth-232)/5+(self.view.widhth-(self.view.widhth-232)/5*2-10)/2+10-3, 100-3, (self.view.widhth-(self.view.widhth-232)/5*2-10)/2+13, 93)];
        url=[NSURL URLWithString:zt.icon];
        request=[[NSURLRequest alloc]initWithURL:url];
        data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        v4.image=[UIImage imageWithData:data];
        v4.userInteractionEnabled=YES;
        UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress4:)];
        [v4 addGestureRecognizer:singleTap4];
        [view addSubview:v4];
        
        [cell addSubview:view];
    }
    if(indexPath.section==4 )
    {
        
        
        HMapp * aoo=self.HMapp[indexPath.row];
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
        if([aoo.price floatValue]==0)
        {
            UIButton * freeb=[[UIButton alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 30, 65, 30)];
            [freeb.layer setMasksToBounds:YES];
            [freeb.layer setCornerRadius:5];
            freeb.backgroundColor=[UIColor orangeColor];
            [freeb setTitle:@"免费" forState:UIControlStateNormal];
            
            
            [cell addSubview:freeb];
        }
        else
        {
            UILabel * nowprice=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 30, 65, 30)];
            nowprice.text=[NSString stringWithFormat:@"$%@" ,aoo.price];
            [cell addSubview:nowprice];
        }
        if([aoo.originprice floatValue] >0)
        {
            UILabel *originprice=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 15, 65, 15)];
            originprice.text=[NSString stringWithFormat:@"¥%@",aoo.originprice];
            originprice.textColor=[UIColor lightGrayColor];
            [originprice setFont:[UIFont systemFontOfSize:12]];
            UILabel * open=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 15+7.5, 65, 1)];
            open.backgroundColor=[UIColor redColor];
            [cell addSubview:originprice];
            [cell addSubview:open];
        }
    }
    if(indexPath.section==5 )
    {
        
        
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
        if([aoo.price floatValue]==0)
        {
            UIButton * freeb=[[UIButton alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 30, 65, 30)];
            [freeb.layer setMasksToBounds:YES];
            [freeb.layer setCornerRadius:5];
            freeb.backgroundColor=[UIColor orangeColor];
            [freeb setTitle:@"免费" forState:UIControlStateNormal];
            
            
            [cell addSubview:freeb];
        }
        else
        {
            UILabel * nowprice=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 30, 65, 30)];
            nowprice.text=[NSString stringWithFormat:@"$%@" ,aoo.price];
            [cell addSubview:nowprice];
        }
        if([aoo.originprice floatValue] >0)
        {
            UILabel *originprice=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 15, 65, 15)];
            originprice.text=[NSString stringWithFormat:@"¥%@",aoo.originprice];
            originprice.textColor=[UIColor lightGrayColor];
            [originprice setFont:[UIFont systemFontOfSize:12]];
            UILabel * open=[[UILabel alloc]initWithFrame:CGRectMake(self.view.widhth-(self.view.widhth-232)/5-65, 15+7.5, 65, 1)];
            open.backgroundColor=[UIColor redColor];
            [cell addSubview:originprice];
            [cell addSubview:open];
        }
    }
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    //取消边框线
    
    [cell setBackgroundView:[[UIView alloc] init]];
    cell.backgroundColor = [UIColor clearColor];


    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 175;
    }
    
    if(indexPath.section==1)
    {
        return 80;
    }
   if(indexPath.section==3)
    {
        return 190;
    }
  
    else
    {
        return 80;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  if(section==1)
  {
    return @"限时免费" ;
  }
    if(section==2)
    {
        return @"精品推荐";
        
    }
    if(section==3)
    {
        return @"装机必备";
        
    }
    if(section==4)
    {
        return @"应用专题";
    }
  
    else
    {
        return nil;
    }
   
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==1)//UIView * more=[[UIView alloc]init];
    {
    UIView *footerView = [[UIView alloc] init];
     footerView.frame=CGRectMake(0, 7, 60, 26);
    footerView.userInteractionEnabled = YES;
   // footerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(20, 7, 100, 26)];
    la.text=@"限时免费";
    la.textColor=[UIColor blackColor];
    [la setFont:[UIFont systemFontOfSize:16]];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame=CGRectMake(self.view.widhth-80, 10, 60, 26);
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:5.0];
    [loginButton setTitle:@"更多" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [loginButton addTarget:self action:@selector(loginBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginButton];
    [footerView addSubview:la];
        return footerView;}
    if(section==2)//UIView * more=[[UIView alloc]init];
    {
        UIView *footerView = [[UIView alloc] init];
        footerView.frame=CGRectMake(0, 7, 60, 26);
        footerView.userInteractionEnabled = YES;
       // footerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(20, 7, 100, 26)];
        la.text=@"精品推荐";
        la.textColor=[UIColor blackColor];
        [la setFont:[UIFont systemFontOfSize:16]];
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        loginButton.frame=CGRectMake(self.view.widhth-80, 10, 60, 26);
        [loginButton.layer setMasksToBounds:YES];
        [loginButton.layer setCornerRadius:5.0];
        [loginButton setTitle:@"更多" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [loginButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [loginButton addTarget:self action:@selector(loginBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:loginButton];
        [footerView addSubview:la];
        return footerView;}
    if(section==3)//UIView * more=[[UIView alloc]init];
    {
        UIView *footerView = [[UIView alloc] init];
        footerView.frame=CGRectMake(0, 7, 60, 26);
        footerView.userInteractionEnabled = YES;
      // footerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(20, 7, 100, 26)];
        la.text=@"应用专题";
        la.textColor=[UIColor blackColor];
        [la setFont:[UIFont systemFontOfSize:16]];
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        loginButton.frame=CGRectMake(self.view.widhth-80, 10, 60, 26);
        [loginButton.layer setMasksToBounds:YES];
        [loginButton.layer setCornerRadius:5.0];
        [loginButton setTitle:@"更多" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [loginButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [loginButton addTarget:self action:@selector(loginBtnClick3:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:loginButton];
        [footerView addSubview:la];
        return footerView;}
    if(section==4)//UIView * more=[[UIView alloc]init];
    {
        UIView *footerView = [[UIView alloc] init];
        footerView.frame=CGRectMake(0, 7, 60, 26);
        footerView.userInteractionEnabled = YES;
      //  footerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(20, 7, 100, 26)];
        la.text=@"黑马闯入";
        la.textColor=[UIColor blackColor];
        [la setFont:[UIFont systemFontOfSize:16]];
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        loginButton.frame=CGRectMake(self.view.widhth-80, 10, 60, 26);
        [loginButton.layer setMasksToBounds:YES];
        [loginButton.layer setCornerRadius:5.0];
        [loginButton setTitle:@"更多" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [loginButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [loginButton addTarget:self action:@selector(loginBtnClick4:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:loginButton];
        [footerView addSubview:la];
        return footerView;}
    if(section==5)//UIView * more=[[UIView alloc]init];
    {
        UIView *footerView = [[UIView alloc] init];
        footerView.frame=CGRectMake(0, 7, 60, 26);
        footerView.userInteractionEnabled = YES;
        //  footerView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
        UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(20, 7, 100, 26)];
        la.text=@"编辑推荐";
        la.textColor=[UIColor blackColor];
        [la setFont:[UIFont systemFontOfSize:16]];
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        loginButton.frame=CGRectMake(self.view.widhth-80, 10, 60, 26);
        [loginButton.layer setMasksToBounds:YES];
        [loginButton.layer setCornerRadius:5.0];
        [loginButton setTitle:@"更多" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [loginButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [loginButton addTarget:self action:@selector(loginBtnClick5:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:loginButton];
        [footerView addSubview:la];
        return footerView;}
    else
    {
        return nil;
    }
}
-(void)loginBtnClick1:(UIButton * )sender
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
   
    de.detailUrl=@"http://applebbx.sj.91.com/api/?act=236&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&spid=2&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=15&mt=1&nt=10&pid=2";
    de.Name=@"限时免费";

}
-(void)loginBtnClick2:(UIButton * )sender
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    
    de.detailUrl=@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=244&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=20&mt=1&nt=10&pid=2";
    de.Name=@"精品推荐";
}
-(void)loginBtnClick3:(UIButton * )sender
{
    /*
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    
    de.detailUrl=@"http://applebbx.sj.91.com/soft/phone/tag.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=212&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&nt=10&mt=1&pid=2";
    de.Name=@"应用专题";*/
    [SVProgressHUD showSuccessWithStatus:@"No more!" duration:1.5];
    
}
-(void)loginBtnClick4:(UIButton * )sender
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    
    de.detailUrl=@"http://applebbx.sj.91.com/soft/phone/list.aspx?cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&act=245&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&spid=2&osv=8.4.1&dm=iPhone7,2&sv=3.1.3&top=10&mt=1&nt=10&pid=2";
    de.Name=@"黑马闯入";
}
-(void)loginBtnClick5:(UIButton * )sender
{
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    MoreTableViewController * de=[[MoreTableViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    
    de.detailUrl=@"http://applebbx.sj.91.com/soft/phone/list.aspx?skip=10&mt=1&spid=2&osv=8.4.1&cuid=3428d2caf0eb10eeb75f39d9d3ed91cdaaf5a419&imei=612976FF-5EC4-4E9C-9C8F-A5689CB586C9&dm=iPhone7,2&sv=3.1.3&act=244&nt=10&pid=2&top=10";
    de.Name=@"编辑推荐";
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
    
    if(indexPath.section==2)
    {
        
        detailpageViewController * de=[[detailpageViewController alloc]init];
        [self.navigationController pushViewController:de animated:YES];
        appbox * a=self.jpapp[indexPath.row];
        de.detailUrl=a.detailurl;
        
    }
    if(indexPath.section==3)
    {
        return ;
        
    }
    if(indexPath.section==4)
    {
     
        detailpageViewController * de=[[detailpageViewController alloc]init];
        [self.navigationController pushViewController:de animated:YES];
        appbox * a=self.HMapp[indexPath.row];
        de.detailUrl=a.detailurl;
        
    }
    if(indexPath.section==5)
    {
      
        detailpageViewController * de=[[detailpageViewController alloc]init];
        [self.navigationController pushViewController:de animated:YES];
        appbox * a=self.BJapp[indexPath.row];
        de.detailUrl=a.detailurl;
        
    }
    return;
}

@end
