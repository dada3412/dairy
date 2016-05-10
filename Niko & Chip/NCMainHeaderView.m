//
//  NCMainHeaderView.m
//  Niko & Chip
//
//  Created by Nico on 16/4/27.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCMainHeaderView.h"
#import "CommenDefine.h"
@implementation NCMainHeaderView

-(instancetype)init
{
    self=[super init];
    if (self) {
        UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeInfoDark];
        leftButton.frame=CGRectMake(0, 44, SCREEN_WIDTH/2, 156);
        leftButton.backgroundColor=MAIN_COLOR;
        [leftButton addTarget:self.delegate action:@selector(tappedLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeContactAdd];
        rightButton.frame=CGRectMake(SCREEN_WIDTH/2,44, SCREEN_WIDTH/2, 156);
        rightButton.backgroundColor=[UIColor colorWithRed:0.173 green:0.687 blue:1.000 alpha:1.000];
        [rightButton addTarget:self.delegate action:@selector(tappedRightButton:) forControlEvents:UIControlEventTouchUpInside];
        UIView *middleLine=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 54, 1, 136)];
        middleLine.backgroundColor=[UIColor whiteColor];
        
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        topView.backgroundColor=MAIN_COLOR;
        
        [self addSubview:topView];
        [self addSubview:leftButton];
        [self addSubview:rightButton];
        [self addSubview:middleLine];
        
    }
    
    return  self;
}


@end
