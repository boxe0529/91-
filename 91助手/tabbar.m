//
//  tabbar.m
//  新博
//
//  Created by 邓云方 on 15/10/18.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "tabbar.h"
#import "UIView+exstion.h"
@interface tabbar()

@property (nonatomic,weak) UIButton * plusButton;

@end

@implementation tabbar
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
       /* UIButton * plusButton=[[UIButton alloc]init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_hightlighted"] forState:UIControlStateSelected];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
         [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
       // [self addSubview:plusButton];
        plusButton.widhth=plusButton.currentBackgroundImage.size.width;
        plusButton.highth=plusButton.currentBackgroundImage.size.height;
        [self addSubview:plusButton];
        self.plusButton=plusButton;*/
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //self.plusButton.center=CGPointMake(self.widhth*0.5, self.highth*0.5);
    /*self.plusButton.centerx=self.widhth*0.5;
    self.plusButton.centery=self.highth*0.5;*/
    int inx=0;
    CGFloat btnw=self.widhth/4;
    for(UIView * view in self.subviews)
    {
        Class class=NSClassFromString(@"UITabBarButton");
        if([view isKindOfClass:class] )
        {
            view.x=inx*btnw;
            inx++;
        }
            }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
