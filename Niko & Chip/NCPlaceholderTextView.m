//
//  NCPlaceHolderTextView.m
//  Niko & Chip
//
//  Created by Nico on 16/5/12.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCPlaceholderTextView.h"

@interface NCPlaceholderTextView()<UITextViewDelegate>
@property (nonatomic,strong)NSString *origString;
@end

@implementation NCPlaceholderTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        if (self.isSizeToFit) {
            self.scrollEnabled=NO;
            self.isAdd=NO;
        }
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.delegate=self;
        self.isAdd=NO;
        
    }
    return self;
}

-(void)setIsSizeToFit:(BOOL)isSizeToFit
{
    _isSizeToFit=isSizeToFit;
    if (_isSizeToFit) {
        self.scrollEnabled=NO;
        self.layer.borderColor=[[UIColor blackColor]CGColor];
        self.layer.borderWidth=0.8;
        self.layer.cornerRadius=5;
        
    }
}

-(UITableView *)tableView
{
    UIView *tableView=self.superview;
    while (![tableView isKindOfClass:[UITableView class]]&&tableView) {
        tableView=tableView.superview;
    }
    return (UITableView *)tableView;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    if ([textView.text isEqualToString:self.placeholder]) {
        textView.text=@"";
        [textView setTextColor:[UIColor blackColor]];
    }else
        self.origString=textView.text;
//    NSLog(@"textView %p begin editing",textView);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        if (self.isSizeToFit && !self.isAdd) {
            textView.text=self.origString;
            [self updateTableView];
        }else
        {
            textView.text=_placeholder;
            [textView setTextColor:[UIColor lightGrayColor]];
        }
    }else
    {
        if (self.isSizeToFit&& !self.isAdd) {
//            NSLog(@"tag:%ld",self.tag);
            [self.placeholderDelegate saveTagData:self.text withIndex:(int)self.tag];
        }else if(!self.isSizeToFit)
        {
            [self.placeholderDelegate saveTitleData:self.text];
            [self setTextColor:[UIColor blackColor]];
        }
        
        
    }
//    NSLog(@"textView %p end editing",textView);
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=placeholder;
    [self textViewDidEndEditing:self];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (self.text.length>0&&self.isAdd) {
            self.addString=self.text;
            [self.placeholderDelegate addTag:self.addString];
            [[self tableView] reloadData];
        }else
        {
            
            
        }
        [textView resignFirstResponder];
        return NO;
    }else
    {
        return YES;
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>self.limitNumbersOfString) {
        textView.text=[textView.text substringToIndex:self.limitNumbersOfString];
    }
    if (self.isSizeToFit) {
        CGSize size=[textView sizeThatFits:CGSizeMake(textView.frame.size.width, CGFLOAT_MAX)];
        CGRect frame=textView.frame;
        frame.size.height=size.height;
        textView.frame=frame;
        [self updateTableView];
    }
    
//    NSLog(@"textView %p didchange text",textView);
    
}

-(void)updateTableView
{
    UITableView *tableView=[self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
}

@end
