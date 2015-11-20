//
//  UIView+exstion.m
//  新博
//
//  Created by 邓云方 on 15/10/18.
//  Copyright (c) 2015年 邓云方. All rights reserved.
//

#import "UIView+exstion.h"

@implementation UIView (exstion)
-(CGFloat)x
{
    return self.frame.origin.x;
    
}
-(void)setX:(CGFloat)x
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}
-(CGFloat)centerx
{
    return self.center.x;
}
-(void)setCenterx:(CGFloat)centerx
{
    CGPoint center=self.center;
    center.x=centerx;
    self.center=center;
}
-(CGFloat)centery
{
    return self.center.y;
}
-(void)setCentery:(CGFloat)centery
{
    CGPoint center=self.center;
    center.y=centery;
    self.center=center;
}
-(CGFloat)widhth
{
    return  self.window.size.width;
}
-(void)setWidhth:(CGFloat)widhth
{
    CGRect frame=self.frame;
    frame.size.width=widhth;
    self.frame=frame;
}
-(CGFloat)highth
{
    return  self.frame.size.height;
}
-(void)setHighth:(CGFloat)highth
{
    CGRect frame=self.frame;
    frame.size.height=highth;
    self.frame=frame;
}
-(CGSize)size
{
    return self.frame.size;
}
-(void)setSize:(CGSize)size
{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}
-(CGPoint)origin
{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin
{
    CGRect frame=self.frame;
    frame.origin=origin;
    self.frame=frame;
}

@end
