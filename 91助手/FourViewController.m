//
//  FourViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "FourViewController.h"
#import "UIView+exstion.h"
#import "AppDelegate.h"
#import "HMapp.h"
#import "FMDatabase.h"
#import "MoreTableViewController.h"
#import "SearchTableViewController.h"
@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title=nil;
   // self.view.backgroundColor=[UIColor colorWithRed:101.0 green:200.0 blue:1 alpha:0.5];
   txt=[[UITextField alloc]initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    //self.view.backgroundColor=[UIColor colorWithRed:1.5 green:1.5 blue:1.0 alpha:0.5];
   // self.tableView.backgroundColor=[UIColor colorWithRed:1.5 green:0.9 blue:1.0 alpha:0.5];
    self.btn.backgroundColor=[UIColor orangeColor];
    self.records=[[NSMutableArray alloc]initWithCapacity:20];
    //self.HMapp=[[NSMutableArray alloc]initWithCapacity:30];
    [txt setBackground:[UIImage imageNamed:@"search_nor"]];
    UIImageView *leftview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_icon"]];
    txt.delegate=self;
    //txt.keyboardType=UIKeyboardTypeWebSearch;
    txt.returnKeyType=UIReturnKeySearch;
    leftview.frame=CGRectMake(0, 0, 25, 25);
    leftview.contentMode=UIViewContentModeCenter;
    txt.leftView=leftview;
    txt.leftViewMode=UITextFieldViewModeAlways;
      self.l1.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent1:)];
    tapGestureTel.delegate=self;
    [self.l1 addGestureRecognizer:tapGestureTel];

    
    self.l2.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent2:)];
    tapGestureTel1.delegate=self;
    [self.l2 addGestureRecognizer:tapGestureTel1];
    
    self.l3.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent3:)];
    tapGestureTel2.delegate=self;
    [self.l3 addGestureRecognizer:tapGestureTel2];

    self.l4.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent4:)];
    tapGestureTel3.delegate=self;
    [self.l4 addGestureRecognizer:tapGestureTel3];

    self.l5.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent5:)];
    tapGestureTel4.delegate=self;
    [self.l5 addGestureRecognizer:tapGestureTel4];

    self.l6.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent6:)];
    tapGestureTel5.delegate=self;
    [self.l6 addGestureRecognizer:tapGestureTel5];

    self.l7.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent7:)];
    tapGestureTel6.delegate=self;
    [self.l7 addGestureRecognizer:tapGestureTel6];

    self.l8.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent8:)];
    tapGestureTel7.delegate=self;
    [self.l8 addGestureRecognizer:tapGestureTel7];

    self.l9.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGestureTel8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teleButtonEvent9:)];
    tapGestureTel8.delegate=self;
    [self.l9 addGestureRecognizer:tapGestureTel8];

   
    self.navigationItem.titleView=txt;
    [self laodCATEData];
    [self laodSearchRecord];
    [self.tableView reloadData];

    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [txt resignFirstResponder];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    AppDelegate * app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    FMDatabase * db=app.db;
   [db executeUpdate:@"insert into searchs(iid ,title) values(?,?)",@"0",txt.text];
    //NSLog(@"searh");
    
    [self laodSearchRecord];
    
    [self.tableView reloadData];
    
    SearchTableViewController * sear=[[SearchTableViewController alloc]init];
    [self.navigationController pushViewController:sear animated:YES];
    sear.Name=txt.text;
 
    return YES;
}

-(void)laodHMData
{
    NSString * str=[NSString stringWithFormat:@"http://applebbx.sj.91.com/api/?keyword=%@&pi=1&spid=2&osv=8.4&cuid=faae36d211866df6c766a91382787b6ffbc69bad&imei=7E9E5960-C042-48C7-80BE-58853D4E749F&dm=iPad5,3&sv=3.1.3&act=203&nt=10&pid=2&mt=1",txt.text];
    //NSLog(@"%@",str);
    str=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *freeurl=[NSURL URLWithString:str];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data==nil)
    {
        NSLog(@"返回");
        return;
    }
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //NSLog(@"%@",free);
    if(free)
    {
        
        NSDictionary * d=free[@"Result"];
        
        NSArray *f =d[@"items"];
        [self.HMapp removeAllObjects];
        
        for( NSDictionary * df in f)
        {
            HMapp * f1=[[HMapp alloc]init];
            
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
            
        }
        
    }

}



-(void)teleButtonEvent1:(UITapGestureRecognizer *)sender
{
    //NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l1.text;
    [txt becomeFirstResponder];
}
-(void)teleButtonEvent2:(UITapGestureRecognizer *)sender
{
   // NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l2.text;
    [txt becomeFirstResponder];
}
-(void)teleButtonEvent3:(UITapGestureRecognizer *)sender
{
    //NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l3.text;
    [txt becomeFirstResponder];
}
-(void)teleButtonEvent4:(UITapGestureRecognizer *)sender
{
   // NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l4.text;
    [txt becomeFirstResponder];
}
-(void)teleButtonEvent5:(UITapGestureRecognizer *)sender
{
    //NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l5.text;
    [txt becomeFirstResponder];
}
-(void)teleButtonEvent6:(UITapGestureRecognizer *)sender
{
    //NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l6.text;
    [txt becomeFirstResponder];
}
-(void)teleButtonEvent7:(UITapGestureRecognizer *)sender
{
    //NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l7.text;
    [txt becomeFirstResponder];
}
-(void)teleButtonEvent8:(UITapGestureRecognizer *)sender
{
   // NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l8.text;
    [txt becomeFirstResponder];
}
-(void)teleButtonEvent9:(UITapGestureRecognizer *)sender
{
  //  NSLog(@"%ld",(long)self.view.tag);
    txt.text=self.l9.text;
    [txt becomeFirstResponder];
}
-(void)laodSearchRecord
{
    AppDelegate * app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    FMDatabase * db=app.db;
    FMResultSet* rs;
    [self.records removeAllObjects];
        rs= [db executeQuery:@"select * from searchs order by title desc"];
        while ([rs next])
        {
            NSString * str=[rs stringForColumn:@"title"];
            [self.records addObject:str];
           // NSLog(@"%@",str);
        }
  
    [self.tableView reloadData];
    

}

-(void)laodCATEData
{
    
    NSURL *freeurl=[NSURL URLWithString:@"http://applebbx.sj.91.com/softs.ashx?cuid=faae36d211866df6c766a91382787b6ffbc69bad&act=104&imei=7E9E5960-C042-48C7-80BE-58853D4E749F&spid=2&osv=8.4&dm=iPad5,3&sv=3.1.3&nt=10&mt=1&pid=2"];
    NSURLRequest * request=[[NSURLRequest alloc]initWithURL:freeurl];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * free=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if(free)
    {
        //app * f1=[[app alloc]init];
        //NSDictionary * d=free[@"Result"];
        // NSLog(@"%@",f);
        NSArray *f =free[@"Result"];
        
        self.l1.text=f[0];
        self.l2.text=f[1];
        self.l3.text=f[2];
        self.l4.text=f[3];
        self.l5.text=f[4];
        self.l6.text=f[5];
        self.l7.text=f[6];
        self.l8.text=f[7];
        self.l9.text=f[8];
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.records.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"meetingCell";
    
    UITableViewCell *cell ;
    cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString * str=self.records[indexPath.row];
    //NSLog(@"%@",str);
    cell.textLabel.text=str;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return  cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if([self.view window]==nil)
    {
        self.view=nil;
    }
}



- (IBAction)delhistory:(id)sender {
    //NSLog(@"delete");
    AppDelegate * app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    FMDatabase * db=app.db;
    BOOL b;
  b=  [db executeUpdate:@"DELETE from searchs"];
    if(!b)
    {
        NSLog(@"没有删除记录");
    }
    //[self laodSearchRecord];
   [self.records removeAllObjects];
    [self.tableView reloadData];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(cell.tag == 0)
    {
        
        
        cell.selected = NO;
    }else
    {
        [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    }

    txt.text= self.records[indexPath.row];
    [txt becomeFirstResponder];
}
@end
