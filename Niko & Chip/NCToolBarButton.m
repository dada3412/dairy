//
//  NCToolBarButton.m
//  Niko & Chip
//
//  Created by Nico on 16/4/25.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCToolBarButton.h"
#import "CommenDefine.h"
@implementation NCToolBarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    [self addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return self;
}

-(void)showView:(UIButton *)sender
{
    
    UITableView *tableView=[[UITableView alloc]init];
    tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    tableView.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    tableView.bounds=CGRectMake(0, 0, 50, 60);
    
    
    
}

@end
