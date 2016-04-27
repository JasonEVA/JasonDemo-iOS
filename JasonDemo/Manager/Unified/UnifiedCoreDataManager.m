//
//  UnifiedCoreDataManager.m
//  CoreDataDemo
//
//  Created by William Zhang on 15/7/20.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import "UnifiedCoreDataManager.h"
//#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface UnifiedCoreDataManager ()

@property (nonatomic, getter=isUsingCoreData) BOOL usingCoreData;

@end

@implementation UnifiedCoreDataManager

#pragma mark - Initializer
+ (UnifiedCoreDataManager *)shareInstance
{
    static UnifiedCoreDataManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

+ (void)openDefaultsCoreData
{
    [self openUsersCoreData:@""];
}

+ (void)openUsersCoreData:(NSString *)userName
{
    // 如果已经建立core Data，需cleanUp后再使用
    if ([self shareInstance].isUsingCoreData)
    {
        [self close];
    }
    
    if (!userName || !userName.length)
    {
        userName = @"default";
    }
    
    NSString *strPath = [NSString stringWithFormat:@"%@/%@.sqlite",userName,userName];
   // [MagicalRecord setupCoreDataStackWithStoreNamed:strPath];
    [self shareInstance].usingCoreData = YES;
}

+ (void)close
{
    if ([self shareInstance].isUsingCoreData)
    {
        //[MagicalRecord cleanUp];
        [self shareInstance].usingCoreData = NO;
    }
}

#pragma mark - Query
//+ (NSArray *)queryFromClass:(Class)classType
//{
//    return [classType MR_findAll];
//}

#pragma mark - Sort
//+ (NSArray *)sortDataClass:(Class)classType sortItem:(NSString *)sortItem ascending:(BOOL)ascending
//{
//    return [classType MR_findAllSortedBy:sortItem ascending:ascending];
//}

//+ (NSArray *)sortDataClass:(Class)classType predicate:(NSPredicate *)searchTerm
//{
//    return [classType MR_findAllWithPredicate:searchTerm];
//}

#pragma mark - Insert
+ (void)insertData:(id)data
{
    [self insertData:data completion:^(BOOL contextDidSave, NSError *error) {}];
}

//+ (void)insertData:(id)data completion:(MRSaveCompletionHandler)completion
//{
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//    // TODO:插入数据
////        Person *person = [Person MR_createEntityInContext:localContext];
////        person.age  = ((Person *)data).age;
////        person.name = ((Person *)data).name;
//    } completion:completion];
//}

+ (void)insertDataWithBlock:(void(^)(NSManagedObjectContext *localContext))block
{
    [self insertDataWithBlock:block completion:^(BOOL contextDidSave, NSError *error) {}];
}

//+ (void)insertDataWithBlock:(void(^)(NSManagedObjectContext *localContext))block completion:(MRSaveCompletionHandler)completion
//{
//    [MagicalRecord saveWithBlock:block completion:completion];
//}

#pragma mark - Update
+ (void)updateData:(id)data {
    [self updateData:data completion:^(BOOL contextDidSave, NSError *error) {}];
}

//+ (void)updateData:(id)data completion:(MRSaveCompletionHandler)completion
//{
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//// TODO:更新数据
//        
////        id dataTmp = [data MR_inContext:localContext];
////        if ([data isKindOfClass:[Person class]]) {
////            Person *updatingPerson = data;
////            Person *updatedPerson = dataTmp;
////            updatedPerson.age = updatingPerson.age;
////            updatedPerson.name = updatingPerson.name;
////            updatedPerson.birthDay = updatingPerson.birthDay;
////        }
//    } completion:completion];
//}

#pragma mark - Delete
+ (void)deleteData:(id)data {
    [self deleteData:data completion:^(BOOL contextDidSave, NSError *error) {}];
}

//+ (void)deleteData:(id)data completion:(MRSaveCompletionHandler)completion
//{
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        [data MR_deleteInContext:localContext];
//    } completion:completion];
//}

#pragma mark - Count
+ (NSUInteger)countOfDataClass:(Class)data
{
    return [self countOfDataClass:[data class] predicate:nil];
}

//+ (NSUInteger)countOfDataClass:(Class)classType predicate:(NSPredicate *)searchFilter
//{
//    return [[classType class] MR_countOfEntitiesWithPredicate:searchFilter];
//}

#pragma mark - Max
+ (id)maxOfDataClass:(Class)classType onAttribute:(NSString *)attributeName
{
    return [self maxOfDataClass:classType onAttribute:attributeName withPredicate:nil];
}

//+ (id)maxOfDataClass:(Class)classType onAttribute:(NSString *)attributeName withPredicate:(NSPredicate *)predicate
//{
//    return [classType MR_aggregateOperation:@"max:" onAttribute:attributeName withPredicate:predicate];
//}

#pragma mark - Min
+ (id)minOfDataClass:(Class)classType onAttribute:(NSString *)attributeName
{
    return [self minOfDataClass:classType onAttribute:attributeName withPredicate:nil];
}

//+ (id)minOfDataClass:(Class)classType onAttribute:(NSString *)attributeName withPredicate:(NSPredicate *)predicate
//{
//    return [classType MR_aggregateOperation:@"min:" onAttribute:attributeName withPredicate:predicate];
//}

@end