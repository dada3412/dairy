//
//  NCHomeTableViewCell.h
//  Niko & Chip
//
//  Created by Nico on 16/4/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCDairyManager.h"

@interface NCHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong,nonatomic)UIImageView *cellImageView;
@property (strong,nonatomic)NSArray *tags;
@property (strong,nonatomic) NCDairy *dairy;


@end
