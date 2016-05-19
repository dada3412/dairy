//
//  NCMainTableViewController.m
//  Niko & Chip
//
//  Created by Nico on 16/4/27.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCHomeTableViewController.h"
#import "NCMainHeaderView.h"
#import "NCHomeTableViewCell.h"
#import "NCDairyManager.h"
#import "NCImageStore.h"
#import "NCDairyEdite.h"
#import "CommenDefine.h"

@interface NCHomeTableViewController()<ButtonTapped,DismisView>
@property (nonatomic,strong)NCDairyManager *dairyManager;
//@property(nonatomic, strong)NSMutableArray *dataArray;

@end
@implementation NCHomeTableViewController

-(instancetype)init
{
    self=[super init];
    self.tableView.backgroundColor=[UIColor whiteColor];

    self.tableView.delegate=self;
    self.tableView.dataSource=self;

    return self;
}



-(NCDairyManager *)dairyManager
{
    return [NCDairyManager shareDairy];
}


#pragma mark --tableView Delegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        NCMainHeaderView *headerView=[[NCMainHeaderView alloc]init];
        return headerView;
    }
    else
        return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 200;
    }else
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        NCDairy *dairy=self.dairyManager.dairies[indexPath.row];
        return dairy.cellH;
    }
    return 0;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NCDairy *dairy=[self.dairyManager dairyFromIndex:indexPath.row];
    NCDairyEdite *detailDairyView=[NCDairyEdite new];
    detailDairyView.dairy=dairy;
    detailDairyView.delegate=self;
    [self presentViewController:detailDairyView animated:YES completion:^{}];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}


#pragma mark --tableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else
        return [self.dairyManager numbersOfDairy];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NCHomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NCHomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NCHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSLog(@"okok");
//        NCDairy *dairy=self.dairyManager.dairies[indexPath.row];
//        cell.dairy=dairy;
    }
    NCDairy *dairy=self.dairyManager.dairies[indexPath.row];
    cell.dairy=dairy;


    
    return cell;
}


#pragma mark --Header Button delegate
-(void)tappedLeftButton:(UIButton *)sender
{
    
}

-(void)tappedRightButton:(UIButton *)sender
{
//    NCDairy *dairy=[self.dairyManager createDairy];
//    dairy.dairyIndex=[self.dairyManager numbersOfDairy]-1;
    NCDairy *dairy=[NCDairy new];
    dairy.dairyIndex=[self.dairyManager numbersOfDairy];
    dairy.createDate=[NSDate date];
    [self.dairyManager addDairy:dairy];
    NCDairyEdite *detailDairyView=[NCDairyEdite new];
    detailDairyView.dairy=dairy;
    detailDairyView.delegate=self;
    [self presentViewController:detailDairyView animated:YES completion:^{}];
}

#pragma mark DairyDetail DismisViewDelegate
-(void)dismisView:(NCDairy *)dairy
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadData];
        [self.dairyManager updateDbWithDairy:dairy];
    }];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
