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
#import "NCDairyManager.h"
#import "CommenDefine.h"
@interface NCDairyEdite ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
- (IBAction)tappedBackButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dateButton;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic)NCImageSection *imageSection;
@end

@implementation NCDairyEdite

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy年MM月dd日 HH:mm"];
    self.dateButton.title=[formatter stringFromDate:self.dairy.createDate];
    
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    NSMutableArray *imageKeys=self.dairy.imageKeys;
    self.imageSection=[NCImageSection initImageSectionWithImageKeys:imageKeys];
    self.imageSection.adelegate=self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)tappedBackButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dismisView)]) {
        [self.delegate dismisView];
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
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

#pragma tableView Delegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return self.imageSection;
    }else
        return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 100;
    }
    else
        return 0;
}

-(void)addImage:(UIButton *)sender
{
    UIImagePickerController *imagePicker=[UIImagePickerController new];
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate=self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma UIPickerImageViewDelgate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *imagekey=[NSString stringWithFormat:@"%lu%ld",self.dairy.dairyIndex,self.dairy.imageKeys.count];
    [self.dairy.imageKeys addObject:imagekey];
    [[NCImageStore shareImage] setImage:image forKey:imagekey];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.imageSection reloadData];
}

@end
