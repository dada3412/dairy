//
//  NCDairyDetailTitle.m
//  Niko & Chip
//
//  Created by Nico on 16/5/11.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCDairyDetailTitle.h"

@interface NCDairyDetailTitle()
@end

@implementation NCDairyDetailTitle

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _textView=[[NCPlaceholderTextView alloc]initWithFrame:CGRectMake(5, 5, 310, 60)];
        _textView.backgroundColor=[UIColor colorWithRed:0.941 green:0.877 blue:0.923 alpha:1.000];
        _textView.placeholder=@"请输入标题或者心情(不超过70字)";
        _textView.limitNumbersOfString=70;
        [self addSubview:_textView];
    }
    return self;
}



@end
