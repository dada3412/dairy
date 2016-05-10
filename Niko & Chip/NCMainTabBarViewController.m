//
//  NCMainTabBarViewController.m
//  Niko & Chip
//
//  Created by Nico on 16/4/23.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCMainTabBarViewController.h"
#import "CommenDefine.h"
#import "NCTabBar.h"
#import "NCHomeTableViewController.h"
#import "NCMainHeaderView.h"

@interface NCMainTabBarViewController ()
@property(nonatomic,strong)NCTableViewSelector *selector;
@end

@implementation NCMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NCHomeTableViewController *firstTableView=[[NCHomeTableViewController alloc]init];
    firstTableView.tabBarItem.title=@"主页";
//    self.view.backgroundColor=[UIColor colorWithRed:0.173 green:0.687 blue:1.000 alpha:1.000];
    firstTableView.tableView.contentInset=UIEdgeInsetsMake(44.0f, 0, 0, 0);

    [self addChildViewController:firstTableView];
    
    UITableViewController *secondTableView=[[UITableViewController alloc]init];
    secondTableView.view.backgroundColor=[UIColor yellowColor];
    secondTableView.tabBarItem.title=@"第二页";
    [self addChildViewController:secondTableView];
    
    UITableViewController *thirdTableView=[[UITableViewController alloc]init];
    
    thirdTableView.view.backgroundColor=[UIColor blueColor];
    thirdTableView.tabBarItem.title=@"第三页";
    [self addChildViewController:thirdTableView];
    
    UITableViewController *forthTableView=[[UITableViewController alloc]init];
    forthTableView.view.backgroundColor=[UIColor whiteColor];
    forthTableView.tabBarItem.title=@"第四页";
    [self addChildViewController:forthTableView];
    
    NCTabBar *nctb=[NCTabBar new];
//    nctb.barTintColor=[UIColor colorWithRed:0.075 green:0.707 blue:0.963 alpha:1.000];

    //是否需要加一个判断
    [self setValue:nctb forKey:@"tabBar"];
    
    NCHomeToolbar *toolbar=[[NCHomeToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_RECT.size.width, 44)];
    
    [self.view addSubview:toolbar];
    
}

-(NCTableViewSelector *)selector
{
    if (!_selector) {
        _selector=[[NCTableViewSelector alloc]init];
    }
    
    return _selector;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --homeToolBar Delegate
-(void)showSelectView:(UIButton *)sender
{
    if (sender.tag==10001) {
        self.selector.delegate=self;
        self.selector.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        self.selector.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
        [self presentViewController:self.selector animated:YES completion:nil];
            }
}

#pragma mark --selector Delegate
-(void)hideView:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
