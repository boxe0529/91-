//
//  detailpageViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/23.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "detailpageViewController.h"
#import "detailApp.h"
#import "addapp.h"
#import "UIView+exstion.h"
#import "SVProgressHUD.h"
@interface detailpageViewController ()<NSURLConnectionDataDelegate>

@end

@implementation detailpageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // NSLog(@"%@",self.detailUrl);
    self.detailapp=[[NSMutableArray alloc]initWithCapacity:3];
    self.addapp=[[NSMutableArray alloc]initWithCapacity:10];
    self.scrollview.contentSize=CGSizeMake(self.view.size.width, self.scrollview.highth);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hint_free.png"] forBarMetrics:UIBarMetricsDefault];
    //NSLog(@"%f",self.scrollview.highth);
    //self.navigationItem.rightBarButtonItem.title=@"Back";
    
    [self.tableview reloadData];
    [self laodDetailData];
    [self.tableview reloadData];
   
       // Do any additional setup after loading the view from its nib.
}

-(void)backtap:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if([self.view window]==nil)
    {
        self.view=nil;
    }
}
-(void)laodDetailData
{
    
    NSURL *freeurl=[NSURL URLWithString:self.detailUrl];
    //NSLog(@"%@",self.detailUrl);
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        
        NSDictionary *df =free[@"Result"];
        [self.detailapp removeAllObjects];
         [self.addapp removeAllObjects];
    
            detailApp * f1=[[detailApp alloc]init];
      
            f1.name=df[@"name"];
            //NSLog(@"%@",f1.name);
            f1.icon=df[@"icon"];
            f1.resid=df[@"resid"];
            f1.price=df[@"price"];
            f1.originprice=df[@"originalPrice"];
            f1.sizes=[df[@"size"] integerValue];
            
            f1.star=[df[@"star"] intValue ];
            f1.downtimes=df[@"downTimes"];
            f1.author=df[@"author"];
            f1.downAct=df[@"downAct"];
            f1.desc=df[@"desc"];
            f1.cateName=df[@"cateName"];
            f1.requirement=df[@"requirement"];
            f1.versionName=df[@"versionName"];
            f1.updatetime=df[@"updateTime"];
            f1.imgs=df[@"snapshots"];
            f1.lan=df[@"lan"];
            NSArray * ar=df[@"recommendSofts"];
            
            for(NSDictionary * dict in ar)
            {
                addapp * ap=[[addapp alloc]init];
                ap.icon=dict[@"icon"];
                ap.detailurl=dict[@"detailUrl"];
                [self.addapp  addObject:ap];
               // NSLog(@"%@",ap.detailurl);
            }
        
        
        int i=0;
        
        for(NSString * strimg in f1.imgs)
        {
            UIImageView * v1=[[UIImageView alloc]initWithFrame:CGRectMake(0+self.view.size.width/2*i, 0, self.view.size.width/2-5, self.scrollview.highth)];
            NSURL*url=[NSURL URLWithString:strimg];
            NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
            NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            v1.image=[UIImage imageWithData:data];
            i=i+1;
            //NSLog(@"%d",i);
            [self.scrollview addSubview:v1];
        }
        self.scrollview.contentSize=CGSizeMake(self.view.size.width/2*(i), self.scrollview.highth);
        self.name.text=f1.name;
        [self.name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [self.view bringSubviewToFront:self.name];
        //NSLog(@"%@",da.name);
        NSURL*url=[NSURL URLWithString:f1.icon];
        NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        self.icon.image=[UIImage imageWithData:data];
        [self.view bringSubviewToFront:self.icon];
        for(int b=0;b<f1.star;b++)
        {
            UIImageView *star=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detail_star.png"]];
            star.frame=CGRectMake((self.view.size.width-232)/5+95+15*b, 210, 12, 10);
            [self.view addSubview:star];
        }
        float a= f1.sizes/(1024*1024);
        self.size.text=[NSString stringWithFormat:@"大小:%.2fMB  版本:%@",a,f1.versionName];
        // NSLog(@"%@",size.text);
        [self.size setFont:[UIFont systemFontOfSize:14]];
        [self.size setTextColor:[UIColor lightGrayColor]];
        
        if([f1.price floatValue]==0)
        {
            
            [self.free.layer setMasksToBounds:YES];
            [self.free.layer setCornerRadius:5];
            self.free.backgroundColor=[UIColor orangeColor];
            [self.free setTitle:@"免费" forState:UIControlStateNormal];
            
        }
        else
        {
            
            NSString * price=[NSString stringWithFormat:@"$%@" ,f1.price];
            [self.free.layer setMasksToBounds:YES];
            [self.free.layer setCornerRadius:5];
            self.free.backgroundColor=[UIColor orangeColor];
            [self.free setTitle:price forState:UIControlStateNormal];
            
            
        }
        if([f1.originprice floatValue] >0)
        {
            UILabel *originprice=[[UILabel alloc]initWithFrame:CGRectMake(self.free.origin.x, self.free.origin.y-15, 65, 15)];
            originprice.text=[NSString stringWithFormat:@"¥%@",f1.originprice];
            originprice.textColor=[UIColor lightGrayColor];
            [originprice setFont:[UIFont systemFontOfSize:12]];
            UILabel * open=[[UILabel alloc]initWithFrame:CGRectMake(self.free.origin.x, self.free.origin.y-15+7.6, 65, 1)];
            open.backgroundColor=[UIColor redColor];
            [self.view addSubview:originprice];
            [self.view addSubview:open];
        }
        
        self.intro.text=f1.desc;
            [self.detailapp addObject:f1];
            //NSLog(@"%@",f1);
        int ii=0;
       for(addapp * ico in self.addapp)
       {
           UIImageView * v1=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.size.width-240)/5+((self.view.size.width-240)/5+60)*ii, 5, 54, 54)];
           NSURL*url=[NSURL URLWithString:ico.icon];
           NSURLRequest * request=[[NSURLRequest alloc]initWithURL:url];
           NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
           v1.userInteractionEnabled=YES;
           UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1:)];
           singleTap1.delegate=self;
           v1.tag=ii;
           [v1 addGestureRecognizer:singleTap1];
           v1.image=[UIImage imageWithData:data];
          v1.layer.cornerRadius = 8;
           v1.layer.masksToBounds = YES;
           ii=ii+1;
           //NSLog(@"%d",ii);
           [self.scroview2 addSubview:v1];
       }
        self.scroview2.contentSize=CGSizeMake(self.view.size.width/4*(ii), self.scroview2.highth);
        self.scroview2.showsHorizontalScrollIndicator=NO;
        self.scrollview.showsHorizontalScrollIndicator=NO;
       /*
        self.author.text=f1.author;
        self.lan.text=f1.lan;
        self.downlaod.text=[NSString stringWithFormat:@"%@次下载",f1.downtimes];
        self.datename.text=f1.cateName;
        self.require.text=f1.requirement;
        //NSLog(@"%@",f1.requirement);
        self.updatetime.text=f1.updatetime;*/
    }
   
}
-(void)buttonpress1:(UITapGestureRecognizer *)sender
{
    //NSLog(@"test");
    //[self handleSingleTap:sender];
    NSLog(@"%ld",sender.view.tag );
    
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    detailpageViewController * de=[[detailpageViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    
    
    addapp * a=self.addapp[sender.view.tag];
    de.detailUrl=a.detailurl;
    //NSLog(@"%@",a.detailurl);
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)UesrClicked:(UITapGestureRecognizer *)recognizer

{
    
    //NSLog(@"%ld",recognizer.view.tag );
    
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    detailpageViewController * de=[[detailpageViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    
    
            addapp * a=self.addapp[recognizer.view.tag];
            de.detailUrl=a.detailurl;
            //NSLog(@"%@",a.detailurl);
    

   
    
}
//响应的方法中，可以获取点击的坐标哦！
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.view];
    //NSLog(@"%fl",point.x);
    [SVProgressHUD showSuccessWithStatus:@"拼命加载中..." duration:1.0];
    detailpageViewController * de=[[detailpageViewController alloc]init];
    [self.navigationController pushViewController:de animated:YES];
    
    for(int i=0;i<self.addapp.count;i++)
    {
        if(point.x==(self.view.size.width-240)/5+((self.view.size.width-240)/5+60)*i)
        {
           addapp * a=self.addapp[i];
            de.detailUrl=a.detailurl;
            //NSLog(@"%@",a.detailurl);
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if(section==0)
  {
    return 5;
   }
   else // Return the number of rows in the section.
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 20;
    }
    else
    {
    return 40;
    }
}-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
    
    detailApp * f1=self.detailapp[0];
    if( indexPath.section==0 && indexPath.row==0)
    {
        cell.textLabel.text=[NSString stringWithFormat:@"下 载：%@次下载",f1.downtimes];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if(indexPath.section==0 && indexPath.row==1)
    {
        cell.textLabel.text=[NSString stringWithFormat:@"分 类：%@",f1.cateName];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if(indexPath.section==0 && indexPath.row==2)
    {
        cell.textLabel.text=[NSString stringWithFormat:@"时 间：%@",f1.updatetime];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if(indexPath.section==0 && indexPath.row==3)
    {
        cell.textLabel.text=[NSString stringWithFormat:@"语 言：%@",f1.lan];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if(indexPath.section==0 && indexPath.row==4)
    {
        cell.textLabel.text=[NSString stringWithFormat:@"作 者：%@",f1.author];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if(indexPath.section==1 && indexPath.row==0)
    {
       cell.textLabel.text=[NSString stringWithFormat:@"兼容性：%@",f1.requirement];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.textLabel.numberOfLines=2;
    }
    return cell;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)downlaodapp:(id)sender {
    //NSLog(@"downlaod");
    detailApp * f1=self.detailapp[0];
    NSURL * pURL = [NSURL URLWithString:f1.downAct];
    //根据URL创建请求
    NSURLRequest * pRequest = [NSURLRequest requestWithURL:pURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    //发起请求，通过委托模式回调完成数据获取
    [NSURLConnection connectionWithRequest:pRequest delegate:self];
    
}
#pragma mark-----NSURLConnectionDataDelegate
//服务器响应回调的方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"服务器响应！");
    //初始化，创建内存空间
    self.pData = [NSMutableData dataWithCapacity:50000];
}

//服务器返回数据，客户端开始接受（data为返回的数据）
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"服务器返回数据！");
    //将返回数据放入缓存
    [self.pData appendData:data];
    
}
//数据接受完毕回调的方法
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"数据接收完毕！");
    //输出接受到的数据
    NSLog(@"pData = %@",self.pData);
    [SVProgressHUD showSuccessWithStatus:@"模拟下载成功"];
}
//接受数据失败的时候调用的方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"数据接受失败，失败的原因：%@",[error localizedDescription]);
}
@end
