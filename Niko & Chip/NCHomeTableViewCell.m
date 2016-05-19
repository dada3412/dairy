//
//  NCHomeTableViewCell.m
//  Niko & Chip
//
//  Created by Nico on 16/4/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCHomeTableViewCell.h"
#import "NCImageStore.h"
#import "NCImageStore.h"
@interface NCHomeTableViewCell()

@end

@implementation NCHomeTableViewCell

#define DISPLAY_WIDTH [UIScreen mainScreen].bounds.size.width-2*5



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self=[[[NSBundle mainBundle] loadNibNamed:@"NCHomeTableViewCell" owner:self options:nil] lastObject];
    return self;
}

-(void)setDairy:(NCDairy *)dairy
{
    if (_dairy!=dairy) {
        _dairy=dairy;
        self.tags=[NSArray arrayWithArray:_dairy.dairytags];
        self.titleLabel.text=_dairy.dairyTitle;
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyy年MM月dd日 HH:mm";
        self.dateLabel.text=[formatter stringFromDate:_dairy.createDate];
//        NSLog(@"123%@",self.dateLabel.text);
        UIFont *textFont=self.titleLabel.font;
        CGRect frame=self.titleLabel.frame;
        frame.size.height=[self.titleLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size.height;
        self.titleLabel.frame=frame;
        self.titleLabel.numberOfLines=0;
        self.dairy.cellH=self.titleLabel.frame.origin.y+frame.size.height+5;
        NSString *imageKey=[dairy.imageKeys firstObject];
        if (imageKey.length>0) {
            self.cellImageView.hidden=NO;
            UIImage *image=[[NCImageStore shareImage] middleImageFromKey:imageKey];
            self.cellImageView.image=image;
            CGFloat imageY=self.dairy.cellH;
//            CGFloat imageViewW=DISPLAY_WIDTH;
            self.cellImageView.frame=(CGRect){{5,imageY},image.size};
            self.dairy.cellH+=image.size.height+5;
        }else
            self.cellImageView.hidden=YES;
//        [self.contentView addSubview:self.cellImageView];
//        [self addDairyTags:_dairy.dairytags];
    }
}

-(void)addDairyTags:(NSArray *)tags
{
    int i=0;
    for (NSString *string in tags) {
        if (string.length>0&&i++<3) {
            CGFloat labelW=DISPLAY_WIDTH-10;
            UIFont *font=[UIFont systemFontOfSize:10.0];
            CGFloat labelH=[string boundingRectWithSize:CGSizeMake(labelW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
            CGRect frame=CGRectMake(15, self.dairy.cellH+5, labelW, labelH);
            UILabel *label=[[UILabel alloc]initWithFrame:frame];
            label.preferredMaxLayoutWidth=DISPLAY_WIDTH;
            [label setFont:font];
            label.text=string;
            
            [self addSubview:label];
//            NSLog(@"cellH2=%lf",self.dairy.cellH);
            self.dairy.cellH+=labelH;
//            NSLog(@"cellH1=%lf",self.dairy.cellH);
        }
    }
    self.dairy.cellH+=10;
}

//-(UIImageView *)cellImageView
//{
//    if (!_cellImageView) {
//        if (self.dairy.imageKeys) {
//            NSString *str=[self.dairy.imageKeys firstObject];
//            if (str.length>0) {
//                CGFloat imageY=self.dairy.cellH;
//                CGFloat imageViewW=DISPLAY_WIDTH;
//                UIImage *image=[[NCImageStore shareImage] middleImageFromKey:str];
//                CGSize imageSize=image.size;
//                _cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, imageY, imageViewW,imageSize.height)];
//                _cellImageView.image=image;
//                _cellImageView.contentMode=UIViewContentModeScaleToFill;
////                NSLog(@"cellH1=%lf",self.dairy.cellH);
//                self.dairy.cellH+=imageSize.height;
//                [self.contentView addSubview:_cellImageView];
////                NSLog(@"cellH image=%lf",self.dairy.cellH);
////                return _cellImageView;
//            }
//        }
////        return _cellImageView;
//
//    }
//    return _cellImageView;
//}

-(UIImageView *)cellImageView
{
    if (!_cellImageView) {
        _cellImageView=[[UIImageView alloc]init];
        [self.contentView addSubview:_cellImageView];
    }
    return _cellImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
