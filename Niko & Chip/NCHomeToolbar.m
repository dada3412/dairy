//
//  NCHomeToolbar.m
//  Niko & Chip
//
//  Created by Nico on 16/4/24.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCHomeToolbar.h"

@implementation NCHomeToolbar
-(instancetype)init
{
    self=[super init];
    self.barStyle=-1;
    

    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
//        [self setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//        [self setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    }
    return self;
}

-(void)layoutSubviews
{
    self.barTintColor=[UIColor colorWithRed:0.173 green:0.687 blue:1.000 alpha:1.000];
    self.opaque=YES;

//    self.bounds=CGRectMake(0, 0, 320, 64);
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
//    CGFloat x=0;
//    CGFloat y=0;
    UIButton *button1=[[UIButton alloc]init];
    button1.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [button1.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button1 setTitle:@"他&她" forState:UIControlStateNormal];
//    [button1 setBackgroundColor:[UIColor blackColor]];
    button1.tag=10001;
    [button1 addTarget:self.aDelegate action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButton1=[[UIBarButtonItem alloc]initWithCustomView:button1];
    
    UIButton *button2=[[UIButton alloc]init];
    [button2 setTitle:@"搜" forState:UIControlStateNormal];
    [button2.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    button2.backgroundColor=[UIColor greenColor];
    button2.tag=10002;
    UIBarButtonItem *barButton2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    
    UIButton *button3=[[UIButton alloc]init];
    [button3 setTitle:@"标" forState:UIControlStateNormal];
    [button3.titleLabel setFont:[UIFont systemFontOfSize:13]];
    button3.tag=10003;
//    button3.backgroundColor=[UIColor orangeColor];
    
        [button1 addTarget:self.aDelegate action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton3=[[UIBarButtonItem alloc]initWithCustomView:button3];
    
    UIButton *button4=[[UIButton alloc]init];
    [button4 setTitle:@"设" forState:UIControlStateNormal];
    [button4.titleLabel setFont:[UIFont systemFontOfSize:13]];
    button4.tag=10004;
//    button4.backgroundColor=[UIColor blueColor];
    UIBarButtonItem *barButton4=[[UIBarButtonItem alloc]initWithCustomView:button4];
    self.items=@[barButton1,barButton2,barButton3,barButton4];
    
    int index=0;
    for (UIView *subView in self.subviews ) {
        Class class=NSClassFromString(@"UIButton");
        subView.backgroundColor=[UIColor clearColor];
//        subView.backgroundColor=[UIColor blackColor];
        if ([subView isKindOfClass:class]) {
            if (index==0) {
                subView.frame=CGRectMake(8, 20, width*0.7, height-20);
                
            }else
            {
                float i=(index-1)/10.0;
                subView.frame=CGRectMake(width*(0.7+i), 20, width*0.1, height-20);
            }
            index++;
            
        }
        
    }
    
    
}





@end
