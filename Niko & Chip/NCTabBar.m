//
//  NCTabBar.m
//  Niko & Chip
//
//  Created by Nico on 16/4/23.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCTabBar.h"
#import "CommenDefine.h"


#define TABBUTTON_COUNT 5
#define TABBUTTON_WIDTH (self.frame.size.width/TABBUTTON_COUNT)
#define TABBAR_WIDTH (self.frame.size.width)
#define TABBUTTON_HEIGHT (self.frame.size.height)

@interface NCTabBar()
@property(strong,nonatomic)UIButton *plusButton;
@end

@implementation NCTabBar

-(UIButton *)plusButton
{
    if (!_plusButton) {
        _plusButton=[[UIButton alloc]init];
        _plusButton.bounds=CGRectMake(0, 0, TABBUTTON_WIDTH, TABBUTTON_HEIGHT);
        [_plusButton setTitle:@"加" forState:UIControlStateNormal];
        [_plusButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        UIButton *button=[[UIButton alloc]init];
    }
    
    return _plusButton;
}


-(void)layoutSubviews
{
//    self.plusButton.center=CGPointMake(TABBAR_WIDTH/2, TABBUTTON_HEIGHT);
    self.plusButton.frame=CGRectMake(TABBUTTON_WIDTH*2, 0, TABBUTTON_WIDTH, TABBUTTON_HEIGHT);
//    NSLog(@"%@",NSStringFromCGRect(self.plusButton.frame));
    [self addSubview:self.plusButton];
    
//    CGFloat x=0;
    CGFloat y=0;
    NSInteger index=0;
    for (UIView *view in self.subviews) {
        Class class=NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.frame=CGRectMake(TABBUTTON_WIDTH*index, y, TABBUTTON_WIDTH, TABBUTTON_HEIGHT);
            index++;
            if (index==2) {
                index++;
            }
        }
    }
}

@end
