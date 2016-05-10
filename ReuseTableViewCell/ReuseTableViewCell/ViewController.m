//
//  ViewController.m
//  ReuseTableViewCell
//
//  Created by Nico on 16/5/7.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *tests;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tests=[NSMutableArray array];
    for (int i=0; i<20; i++) {
        NSString *str=[NSString stringWithFormat:@"test%d",i];
        [self.tests addObject:str];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
//    static NSString *CellIdentifier = @"cell1";
//    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        NSLog(@"cell==nil inside");
//    }
//    UILabel *labelTest = [[UILabel alloc]init];
//    [labelTest setFrame:CGRectMake(2, 2, 80, 40)];
//    [labelTest setBackgroundColor:[UIColor clearColor]];  //之所以这里背景设为透明，就是为了后面让大家看到cell上叠加的label。
//    [labelTest setTag:1];
//    [[cell contentView]addSubview:labelTest];
//    [labelTest setText:[self.tests objectAtIndex:indexPath.row]];
//    NSLog(@"cell==nil outside");
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell1";
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        UILabel *labelTest = [[UILabel alloc]init];
        
        [labelTest setFrame:CGRectMake(2, 2, 80, 40)];
        [labelTest setBackgroundColor:[UIColor clearColor]];
        [labelTest setTag:1];
        [[cell contentView]addSubview:labelTest];
        NSLog(@"cell==nil inside");
    }
    UILabel *label1 = (UILabel*)[cell viewWithTag:1];
    [label1 setText:[self.tests objectAtIndex:indexPath.row]];
    NSLog(@"cell==nil outside");
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tests.count;
}

@end
