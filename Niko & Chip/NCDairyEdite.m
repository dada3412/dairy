//
//  NCDairyEdite.m
//  Niko & Chip
//
//  Created by Nico on 16/5/6.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCDairyEdite.h"

#import "NCAddImageCell.h"
#import "NCImageViewCell.h"
#import "NCImageStore.h"
#import "NCDairyDetailTitle.h"
#import "NCDairyTagCell.h"
#import "CommenDefine.h"
@interface NCDairyEdite ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PlaceholderDelegate>
- (IBAction)tappedBackButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dateButton;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic)NCDairyDetailTitle *detailTitle;
@property (strong,nonatomic)NCImageSection *imageSection;
@property (nonatomic)NSInteger currentIndex;
@end

@implementation NCDairyEdite

//static int currentIndex=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy年MM月dd日 HH:mm"];
    self.dateButton.title=[formatter stringFromDate:self.dairy.createDate];

    self.tableview.rowHeight=UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight=60;
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
//    NSLog(@"main:%p",self.tableview);
    NSMutableArray *imageKeys=self.dairy.imageKeys;
    self.imageSection=[NCImageSection initImageSectionWithImageKeys:imageKeys];
    self.imageSection.adelegate=self;
    
    UINib *nib=[UINib nibWithNibName:@"NCDairyTagCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"TagCell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)tappedBackButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dismisView:)]) {
        if ([self.detailTitle.textView.text isEqualToString:self.detailTitle.textView.placeholder]) {
            self.dairy.dairyTitle=@"";
        }else
            self.dairy.dairyTitle=self.detailTitle.textView.text;
        [self.delegate dismisView:self.dairy];
    }else
    {
        @throw [NSException exceptionWithName:@"delegate无法执行dismisView" reason:@"在delegate中实现dismisView方法" userInfo:nil];
    }
    
}




#pragma mark tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 0;
    }else
        return self.dairy.dairytags.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NCDairyTagCell *cell=[tableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
    if (indexPath.row==self.dairy.dairytags.count) {
        cell.dairyTag.isAdd=YES;
        cell.dairyTag.placeholderDelegate=self;
    }else
    {
        cell.dairyTag.isAdd=NO;
        cell.dairyTag.text=self.dairy.dairytags[indexPath.row];
        cell.dairyTag.tag=indexPath.row;
//        NSLog(@"cell tag:%ld",cell.dairyTag.tag);
        [cell.dairyTag setTextColor:[UIColor blackColor]];
        cell.dairyTag.placeholderDelegate=self;
    }
    return cell;
}

#pragma mark tableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndex=(int)indexPath.row;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return self.imageSection;
    }else
    {
        self.detailTitle=[[NCDairyDetailTitle alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        self.detailTitle.textView.placeholderDelegate=self;
        if (self.dairy.dairyTitle.length>0) {
            self.detailTitle.textView.text=self.dairy.dairyTitle;
            [self.detailTitle.textView setTextColor:[UIColor blackColor]];
        }
        return self.detailTitle;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 100;
    }
    else
        return 70;
}

#pragma mark AddImageDelegate
-(void)addImage:(UIButton *)sender
{
    UIImagePickerController *imagePicker=[UIImagePickerController new];
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate=self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark UIPickerImageViewDelgate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *imagekey=[NSString stringWithFormat:@"%lu%ld",self.dairy.dairyIndex,self.dairy.imageKeys.count];
    [self.dairy.imageKeys addObject:imagekey];
    [[NCImageStore shareImage] setImage:image forKey:imagekey];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.imageSection reloadData];
}


#pragma mark AddTag
-(void)addTag:(NSString *)str
{
    [self.dairy.dairytags addObject:str];
}

-(void)saveTitleData:(NSString *)str
{
    self.dairy.dairyTitle=str;
}

-(void)saveTagData:(NSString *)str withIndex:(int)index
{
    self.dairy.dairytags[index]=str;
}
@end
