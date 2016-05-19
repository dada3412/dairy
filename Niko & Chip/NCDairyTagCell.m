//
//  NCDairyTagCell.m
//  Niko & Chip
//
//  Created by Nico on 16/5/12.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCDairyTagCell.h"
@implementation NCDairyTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.dairyTag.placeholder=@"添加标签";
    self.dairyTag.limitNumbersOfString=1000;
    self.dairyTag.isSizeToFit=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(UITableView *)tableView
//{
//    UIView *tableView=self.superview;
//    while (![tableView isKindOfClass:[UITableView class]]&&tableView) {
//        tableView=tableView.superview;
//    }
//    return (UITableView *)tableView;
//}

//-(void)textViewDidChange:(UITextView *)textView
//{
//    CGRect bounds = textView.bounds;
//    // 计算 text view 的高度
//    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
//    CGSize newSize = [textView sizeThatFits:maxSize];
//    bounds.size = newSize;
//    textView.bounds = bounds;
//    // 让 table view 重新计算高度
//    UITableView *tableView = [self tableView];
//    [tableView beginUpdates];
//    [tableView endUpdates];
//}

@end
