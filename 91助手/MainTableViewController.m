//
//  MainTableViewController.m
//  91助手
//
//  Created by 邓云方 on 15/10/21.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "MainTableViewController.h"
//#import "NavViewController.h"
#import "UIView+exstion.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage * img=  [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage=img;
    self.title=@"首页";
   // NavViewController * nav=[[NavViewController alloc]init];
    self.navigationItem.title=@"91助手";
    //修改字体的颜色
    NSMutableDictionary * arr=[[NSMutableDictionary alloc]init];
    arr[NSForegroundColorAttributeName]=[UIColor orangeColor];
    
    NSMutableDictionary * arr2=[[NSMutableDictionary alloc]init];
    arr2[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    
    [self.tabBarItem setTitleTextAttributes:arr2 forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:arr forState:UIControlStateSelected];
    // Uncomment the following line to preserve selection between presentations.
    
    for(int i=0;i<3;i++)
    {
        NSString * imgname=[NSString stringWithFormat:@"aboutBg@2x.png"];
        UIImage * img=[UIImage imageNamed:imgname];
        UIImageView * imgview=[[UIImageView alloc]initWithImage:img];
        imgview.x=0;
        imgview.x=self.view.widhth*i;
        imgview.widhth=self.view.widhth;
        imgview.highth=self.scrollview.highth;
         [self.scrollview addSubview:imgview];
    }
    self.scrollview.contentSize=CGSizeMake(self.view.widhth*3, self.scrollview.highth);
    self.scrollview.bounces=NO;
    self.scrollview.pagingEnabled=YES;
    //self.pagecontrol=[[UIPageControl alloc]init];
    self.pagecontrol.numberOfPages=3;
    self.pagecontrol.currentPage=0;
    self.pagecontrol.currentPageIndicatorTintColor=[UIColor redColor];
    self.pagecontrol.pageIndicatorTintColor=[UIColor grayColor];
    self.pagecontrol.centerx=self.view.widhth*0.5;
    self.pagecontrol.centery=self.scrollview.highth-15;
    
   
    /*[self.tableview addSubview:self.scrollview];
    [self.tableview addSubview:self.pagecontrol];*/
    self.scrollview.delegate=self;
    self.tableview.delegate=self;
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 滚动监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point=scrollView.contentOffset;
    CGFloat x=point.x;
    CGFloat pageindex=(x+self.view.widhth*0.5)/self.view.widhth;
    self.pagecontrol.currentPage=pageindex;
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(section==0)
    {
        return 1;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section>0)
    {
        return 30;
        
    }
    else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil)
    {
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if(indexPath.section==0)
    {
       // [cell addSubview:self.scrollview];
       // [cell addSubview:self.pagecontrol];
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 170;
    }
    else
    {
        return 100;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
