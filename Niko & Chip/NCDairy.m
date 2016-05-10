//
//  NCDairy.m
//  Niko & Chip
//
//  Created by Nico on 16/4/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCDairy.h"
@interface NCDairy()

@end
@implementation NCDairy
+(instancetype)newDairy
{
    NCDairy *newDairy=[NCDairy new];
    newDairy.createDate=[NSDate date];
    return newDairy;
}

-(NSMutableArray *)imageKeys
{
    if (!_imageKeys) {
        _imageKeys=[NSMutableArray array];
    }
    return  _imageKeys;
}

-(NSMutableArray *)dairytags
{
    if (!_dairytags) {
        _dairytags=[NSMutableArray array];
    }
    return _dairytags;
}
@end
