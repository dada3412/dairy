//
//  NCDairyTagCell.h
//  Niko & Chip
//
//  Created by Nico on 16/5/12.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCPlaceholderTextView.h"
@interface NCDairyTagCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet NCPlaceholderTextView *dairyTag;

@end
