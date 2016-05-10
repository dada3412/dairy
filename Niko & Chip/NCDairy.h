//
//  NCDairy.h
//  Niko & Chip
//
//  Created by Nico on 16/4/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCDairy : NSObject
@property (nonatomic)NSUInteger dairyIndex;
@property (strong,nonatomic)NSString *dairyTitle;
@property (strong,nonatomic)NSString *dairyDate;
@property (strong,nonatomic)NSString *dairyDetail;
@property (strong,nonatomic)NSString *dairyRemarks;
@property (strong,nonatomic)NSMutableArray *dairytags;
@property (strong,nonatomic)NSMutableArray *imageKeys;
@property (nonatomic,strong)NSDate *createDate;
@property (nonatomic)CGFloat cellH;
+(instancetype)newDairy;
@end
