//
//  UnifiedCoreDataManager.h
//  CoreDataDemo
//
//  Created by William Zhang on 15/7/20.
//  Copyright (c) 2015年 William Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

typedef void (^MRSaveCompletionHandler)(BOOL contextDidSave, NSError *error);

@interface UnifiedCoreDataManager : NSObject

/** 开启默认路径数据库（Documents） */
+ (void)openDefaultsCoreData;
/**
 *  开启数据库
 *
 *  @param userName 数据库地址(存储Documents/userName)
 */
+ (void)openUsersCoreData:(NSString *)userName;

+ (void)close;

/**
 *  搜索信息
 *
 *  @param classType 类型class
 *
 *  @return 数据列表
 */
+ (NSArray *)queryFromClass:(Class)classType;

#pragma mark - Sort
/**
 *  排序
 *
 *  @param classType 排序对象Class
 *  @param sortItem  排序标识
 *  @param ascending 升序（YES/NO）
 */
+ (NSArray *)sortDataClass:(Class)classType sortItem:(NSString *)sortItem ascending:(BOOL)ascending;

/**
 *  自定义查询
 *
 *  @param data       查询对象Class
 *  @param searchTerm 查询范围
 *
 *  @return 范围内数据
 */
+ (NSArray *)sortDataClass:(Class)classType predicate:(NSPredicate *)searchTerm;

#pragma mark - Insert
+ (void)insertData:(id)data;
+ (void)insertData:(id)data completion:(MRSaveCompletionHandler)completion;

+ (void)insertDataWithBlock:(void(^)(NSManagedObjectContext *localContext))block NS_DEPRECATED_IOS(2_0, 3_0);
+ (void)insertDataWithBlock:(void(^)(NSManagedObjectContext *localContext))block completion:(MRSaveCompletionHandler)completion NS_DEPRECATED_IOS(2_0, 3_0);

#pragma mark - Update
+ (void)updateData:(id)data;
+ (void)updateData:(id)data completion:(MRSaveCompletionHandler)completion;

+ (void)deleteData:(id)data;
+ (void)deleteData:(id)data completion:(MRSaveCompletionHandler)completion;

#pragma mark - Count
/** 数据个数 */
+ (NSUInteger)countOfDataClass:(Class)data;

/**
 *  数据个数
 *
 *  @param classType    对象class
 *  @param searchFilter 查询过滤
 *
 *  @return 个数
 */
+ (NSUInteger)countOfDataClass:(Class)classType predicate:(NSPredicate *)searchFilter;

#pragma mark - Max

/**
 *  搜索最大值
 *
 *  @param classType     对象class
 *  @param attributeName 搜索关键字
 *
 *  @return 最大值
 */
+ (id)maxOfDataClass:(Class)classType onAttribute:(NSString *)attributeName;

/**
 *  搜索最大值
 *
 *  @param classType     对象class
 *  @param attributeName 搜索关键字
 *  @param predicate     查询条件
 *
 *  @return 最大值
 */
+ (id)maxOfDataClass:(Class)classType onAttribute:(NSString *)attributeName withPredicate:(NSPredicate *)predicate;
#pragma mark - Min

/**
 *  搜索最小值
 *
 *  @param classType     对象class
 *  @param attributeName 搜索关键字
 *
 *  @return 最小值
 */
+ (id)minOfDataClass:(Class)classType onAttribute:(NSString *)attributeName;

/**
 *  搜索最小值
 *
 *  @param classType     对象class
 *  @param attributeName 搜索关键字
 *  @param predicate     查询条件
 *
 *  @return 最小值
 */
+ (id)minOfDataClass:(Class)classType onAttribute:(NSString *)attributeName withPredicate:(NSPredicate *)predicate;

@end
