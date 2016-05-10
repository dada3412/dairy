//
//  NCAddImageCell.m
//  Niko & Chip
//
//  Created by Nico on 16/4/30.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCAddImageCell.h"

@implementation NCAddImageCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:CGRectMake(0, 0, 80, 80)];
    _addImageButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    [_addImageButton setTitle:@"Add" forState:UIControlStateNormal];
    [_addImageButton setBackgroundColor:[UIColor colorWithRed:0.124 green:0.542 blue:1.000 alpha:1.000]];
    [self addSubview:_addImageButton];
    return self;
    
}


@end
