//
//  NCImageViewCell.m
//  Niko & Chip
//
//  Created by Nico on 16/4/30.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCImageViewCell.h"

@implementation NCImageViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"NCImageViewCell" owner:self options:nil];
    return [views firstObject];
}

@end
