//
//  NCTableViewSelector.m
//  Niko & Chip
//
//  Created by Nico on 16/4/26.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCTableViewSelector.h"
#import "CommenDefine.h"
@implementation NCTableViewSelector
//-(instancetype)init
//{
//    self=[super init];
//    if (self) {
//            }
//    return  self;
//}

-(void)loadView
{
    UIButton *backgroundButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [backgroundButton setBackgroundColor:[UIColor blackColor]];
    [backgroundButton setAlpha:0.1];
    [backgroundButton addTarget:self.delegate action:@selector(hideView:) forControlEvents:UIControlEventTouchUpInside];
    self.view=backgroundButton;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    tableView.bounds=CGRectMake(0, 0, 120, 120);
    tableView.backgroundColor=[UIColor yellowColor];

    [self.view addSubview:tableView];

}


@end
