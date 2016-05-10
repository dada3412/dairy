//
//  NCDairyManager.h
//  Niko & Chip
//
//  Created by Nico on 16/4/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCDairy.h" 
@interface NCDairyManager : NSObject<NSCopying>
@property (strong,nonatomic)NSArray *dairies;

+(NCDairyManager *)shareDairy;
-(NCDairy *)createDairy;
-(void)deleteDairy:(NCDairy *)dairy;
-(NCDairy *)dairyFromIndex:(NSUInteger)index;
-(NSInteger)numbersOfDairy;
@end
