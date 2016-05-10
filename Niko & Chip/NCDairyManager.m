//
//  NCDairyManager.m
//  Niko & Chip
//
//  Created by Nico on 16/4/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCDairyManager.h"
@interface  NCDairyManager()
@property (strong,nonatomic)NSMutableArray *privateDairies;
@end


@implementation NCDairyManager

-(NSArray *)dairies
{
    return self.privateDairies;
}

-(NSMutableArray *)privateDairies
{
    if (!_privateDairies) {
        _privateDairies=[NSMutableArray array];
    }
    return _privateDairies;
}

//singleton
static NCDairyManager *dairyManager;

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dairyManager=[super allocWithZone:zone];
    });
    
    return dairyManager;
}

+(NCDairyManager *)shareDairy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dairyManager=[[self alloc]init];
    });
    return dairyManager;
}

-(id)copyWithZone:(NSZone *)zone
{
    return dairyManager;
}

//增删改查

-(NCDairy *)createDairy
{
    NCDairy *dairy=[NCDairy newDairy];
    
    [self.privateDairies addObject:dairy];
    return dairy;
}


-(void)deleteDairy:(NCDairy *)dairy
{
    [self.privateDairies removeObject:dairy];
}

-(NCDairy *)dairyFromIndex:(NSUInteger)index
{
    return self.privateDairies[index];
}

-(NSInteger)numbersOfDairy
{
    return [self.privateDairies count];
}
@end
