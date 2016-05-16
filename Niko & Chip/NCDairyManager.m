//
//  NCDairyManager.m
//  Niko & Chip
//
//  Created by Nico on 16/4/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCDairyManager.h"
#import <sqlite3.h>
@interface  NCDairyManager()
{
    sqlite3 *db;
}
@property (strong,nonatomic)NSMutableArray *privateDairies;
@end


@implementation NCDairyManager

-(NSArray *)dairies
{
    return self.privateDairies;
}

-(NSMutableArray *)privateDairies
{
    if (!_privateDairies) {
        _privateDairies=[NSMutableArray array];
    }
    return _privateDairies;
}

//singleton
static NCDairyManager *dairyManager;

-(void)initWithDB
{
    NSString *pathFile=[self dataBaseDirectoryFile];
    if (sqlite3_open(pathFile.UTF8String, &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"manager：打开db文件失败");
    }else
    {
        NSString *createTable=@"create table if not exists dairy(id integer primary key autoincrement, dairyIndex integer, dairyTitle text, dairyRemarks text, dairyTags text, imageKeys text, createDate text, cellH real)";
        
        char *err=NULL;
        if (sqlite3_exec(db, [createTable UTF8String], NULL, NULL, &err)!=SQLITE_OK) {
            NSLog(@"执行sql命令失败:%s",err);
        }
    }
    
    NSString *selectSql=@"select * from dairy";
    sqlite3_stmt *state;
    if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &state, NULL)==SQLITE_OK) {
        while (sqlite3_step(state)==SQLITE_ROW) {
            NCDairy *dairy=[[NCDairy alloc]init];
            dairy.dairyIndex=sqlite3_column_int(state, 1);
            dairy.dairyTitle=(char *)sqlite3_column_text(state, 2)?[NSString stringWithUTF8String:(char *)sqlite3_column_text(state, 2)]:nil;
            dairy.dairyRemarks=(char *)sqlite3_column_text(state, 3)?[NSString stringWithUTF8String:(char *)sqlite3_column_text(state, 3)]:nil;
            
            NSString *tagsString=(char *)sqlite3_column_text(state, 4)?[NSString stringWithUTF8String:(char *)sqlite3_column_text(state, 4)]:nil;
            NSArray *tagsArray=[tagsString componentsSeparatedByString:@"/*@"];
            dairy.dairytags=[NSMutableArray arrayWithArray:tagsArray];
            
            NSString *imageKeys=(char *)sqlite3_column_text(state, 5)?[NSString stringWithUTF8String:(char *)sqlite3_column_text(state, 5)]:nil;
            NSArray *imageKeysArray=[imageKeys componentsSeparatedByString:@"/*@"];
            dairy.imageKeys=[NSMutableArray arrayWithArray:imageKeysArray];
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateString=(char *)sqlite3_column_text(state, 6)?[NSString stringWithUTF8String:(char *)sqlite3_column_text(state, 6)]:nil;
            dairy.createDate=[formatter dateFromString:dateString];

            [self.privateDairies addObject:dairy];
        }
    }
    
    sqlite3_finalize(state);
    sqlite3_close(db);
}



+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dairyManager=[super allocWithZone:zone];
        
    });
    
    return dairyManager;
}

+(NCDairyManager *)shareDairy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dairyManager=[[self alloc]init];
        [dairyManager initWithDB];
    });
    return dairyManager;
}

-(id)copyWithZone:(NSZone *)zone
{
    return dairyManager;
}

//增删改查

-(NCDairy *)createDairy
{
    NCDairy *dairy=[NCDairy newDairy];
    [self.privateDairies addObject:dairy];
    
    NSString *filePath=[self dataBaseDirectoryFile];
    if (sqlite3_open([filePath UTF8String], &db)!=SQLITE_OK) {
        NSLog(@"fail to open the database!");
        sqlite3_close(db);
    }
    
    NSString *insertSQL=@"insert into dairy(dairyIndex,dairyTitle) value(?,?)";
    sqlite3_stmt *state;
    if (sqlite3_prepare_v2(db, [insertSQL UTF8String], -1, &state, NULL)==SQLITE_OK) {
        sqlite3_bind_int(state, 1, (int)dairy.dairyIndex);
        sqlite3_bind_text(state, 2, [dairy.dairyTitle UTF8String], -1, NULL);
        if (sqlite3_step(state)!=SQLITE_DONE) {
            NSLog(@"insert failed");
        }
    }
    sqlite3_finalize(state);
    sqlite3_close(db);
    
    return dairy;
}


-(void)deleteDairy:(NCDairy *)dairy
{
    [self.privateDairies removeObject:dairy];
}

-(NCDairy *)dairyFromIndex:(NSUInteger)index
{
    return self.privateDairies[index];
}

-(NSInteger)numbersOfDairy
{
    return [self.privateDairies count];
}

-(NSString *)dataBaseDirectoryFile
{
    NSString *documentsFilePath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbPathFile=[documentsFilePath stringByAppendingPathComponent:@"sqlite.db"];
    NSLog(@"dbPathFile %@",dbPathFile);
    return dbPathFile;
}

-(void)updateDbWithDairy:(NCDairy *)dairy
{
    NSString *pathFile=[self dataBaseDirectoryFile];
    if (sqlite3_open([pathFile UTF8String], &db)!=SQLITE_OK) {
        NSLog(@"open db file failed!");
        sqlite3_close(db);
    }
//    NSString *createTable=@"create table if not exists dairy(id integer primary key autoincrement, dairyIndex integer, dairyTitle text, dairyRemarks text, dairyTags text, imageKeys text, createDate text, cellH real)";
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString=[formatter stringFromDate:dairy.createDate];
    
    NSString *dairyTags=[dairy.dairytags componentsJoinedByString:@"/*@"];
    NSString *imageKeys=[dairy.imageKeys componentsJoinedByString:@"/*@"];
    NSString *updateSQLString=[NSString stringWithFormat:@"update dairy set dairyTitle='%@',dairyRemarks='%@', dairyTags='%@', imageKeys='%@', createDate='%@', cellH=%lf where dairyIndex=%lu",dairy.dairyTitle , dairy.dairyRemarks,dairyTags, imageKeys, dateString, dairy.cellH,(unsigned long)dairy.dairyIndex];
    
    const char *updateSQL=[updateSQLString UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, updateSQL, -1, &statement, NULL)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
        }
    }else {
        NSAssert1(0,@"Error:%s",sqlite3_errmsg(db));
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(db);
    
}

-(void)addDairy:(NCDairy *)dairy
{
    [self.privateDairies addObject:dairy];
    NSString *filePath=[self dataBaseDirectoryFile];
    if (sqlite3_open([filePath UTF8String], &db)!=SQLITE_OK) {
        NSLog(@"fail to open the database!");
        sqlite3_close(db);
    }
    
    NSString *insertSQL=@"insert into dairy(dairyIndex) values(?)";
    sqlite3_stmt *state;
    if (sqlite3_prepare_v2(db, [insertSQL UTF8String], -1, &state, NULL)==SQLITE_OK) {
        sqlite3_bind_int(state, 1, (int)dairy.dairyIndex);
//        sqlite3_bind_text(state, 2, [dairy.dairyTitle UTF8String], -1, NULL);
        if (sqlite3_step(state)!=SQLITE_DONE) {
            NSLog(@"insert failed");
        }
    }
    sqlite3_finalize(state);
    sqlite3_close(db);

}
@end
