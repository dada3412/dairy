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

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self=[super initWithFrame:frame];
////    self=[[[NSBundle mainBundle] loadNibNamed:@"NCHomeTableViewCell" owner:self options:nil] lastObject];
////    return self;
////        UIView *view=[[[NSBundle mainBundle] loadNibNamed:@"NCHomeTableViewCell" owner:self options:nil] lastObject];
////    self.contentView;
////        [self setValue:view forKeyPath:@"contentView"];
//    NSLog(@"initFrame");
//        return self;
//}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self=[[[NSBundle mainBundle] loadNibNamed:@"NCHomeTableViewCell" owner:self options:nil] lastObject];
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
//    view.backgroundColor=[UIColor blueColor];
//    [self addSubview:view];
//    NSLog(@"init style");
    return self;
//
}

-(void)setDairy:(NCDairy *)dairy
{
    if (_dairy!=dairy) {
        _dairy=dairy;
        self.tags=[NSArray arrayWithArray:_dairy.dairytags];
        self.titleLabel.text=_dairy.dairyTitle;
        //        self.titleLabel.text=@"我相信，人生总有辉煌，光明总会在不远的地方，上天请让我，再坚强一些，当我将要倒下，在这无靠无依的大桥下";
        UIFont *textFont=self.titleLabel.font;
        CGFloat height=[self.titleLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size.height;
        self.titleLabel.numberOfLines=0;
        self.dateLabel.text=_dairy.dairyDate;
        self.dairy.cellH=self.titleLabel.frame.origin.y+height+5;
        [self addSubview:self.cellImageView];
        [self addDairyTags:_dairy.dairytags];
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

-(UIImageView *)cellImageView
{
    if (!_cellImageView) {
        if (self.dairy.imageKeys) {
            NSString *str=[self.dairy.imageKeys firstObject];
            if (str.length>0) {
                CGFloat imageY=self.dairy.cellH;
                CGFloat imageViewW=DISPLAY_WIDTH;
                NSString *imagekey=[_dairy.imageKeys firstObject];
                UIImage *image=[[NCImageStore shareImage] middleImageFromKey:imagekey];
                CGSize imageSize=image.size;
                _cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, imageY, imageViewW,imageSize.height)];
                _cellImageView.image=image;
                _cellImageView.contentMode=UIViewContentModeScaleToFill;
//                NSLog(@"cellH1=%lf",self.dairy.cellH);
                self.dairy.cellH+=imageSize.height;
//                NSLog(@"cellH image=%lf",self.dairy.cellH);
                return _cellImageView;
            }
        }
        return _cellImageView;

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
