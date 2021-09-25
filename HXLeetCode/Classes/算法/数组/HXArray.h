//
//  HXArray.h
//  算法
//
//  Created by HX on 2021/3/29.
//

#import <Foundation/Foundation.h>
//#import "HXTree.h"

NS_ASSUME_NONNULL_BEGIN

@interface HXArray : NSObject

#pragma mark - 两数之和
+ (NSArray*)violenceTwoSum:(NSArray*)nums target:(int)target; // 暴力解法

+ (NSArray*)hashTwoSum:(NSArray*)nums target:(int)target;     // hash表


#pragma mark - 合并两个有序数组
+ (void)mergeArray:(NSMutableArray *)numsFirst firstSize:(NSInteger)m
           withTarget:(NSArray *)numsSecond secondSize:(NSInteger)n ; // 解法：逆向双指针

#pragma mark - 螺旋矩阵

#pragma mark - 斐波那契数列
+ (NSInteger)fib:(NSInteger)n; // 循环解法

+ (NSInteger)fib_recursive:(NSInteger)n;// 递归解法


#pragma mark - 累加求和
+ (NSInteger)sum:(NSInteger)n;


#pragma mark - 三数之和


#pragma mark - 重建二叉树
//+ (TreeNode *)buildTreePreodrder:(NSArray *)preorder withInorder:(NSArray *)inorder;

#pragma mark - 转动过的有序数组

#pragma mark - 股票（一次交易）
+ (NSInteger)maxProfit:(NSArray *)prices;// 解法：一次遍历


#pragma mark - 求众数
+ (NSInteger)majorityElement:(NSArray *)nums;


#pragma mark - 最小路径和
+ (NSInteger)minPathSum:(NSArray<NSArray *>*)grid; // 解法：动态规划


#pragma mark - 缺失的数字
+ (NSInteger)missingNumber:(NSArray *)nums;


#pragma mark - 最小的k个数
// 解法1：排序，对原数组从小到大排序后取出前k个数即可。
// 解法2：借鉴快速排序的思想，
+ (NSArray *)getLeastNumbers:(NSArray *)nums withNums:(NSInteger)k;


#pragma mark - 寻找第K大
+ (NSInteger)findKth:(NSArray *)nums;


#pragma mark - 数组中只出现一次的数（其它数出现k次）
+ (NSInteger)foundOnceNumber:(NSArray *)nums;


#pragma mark - 排序
+ (NSArray *)sortWithBubble:(NSMutableArray *)srcArray; // 1、冒泡排序

+ (void)fastSort:(NSMutableArray *)srcArray left:(NSInteger)low right:(NSInteger)high;// 快速排序


#pragma mark - 最长不含重复字符的子字符串
// 解法：动态规划  +  哈希表
// 定义状态：设动态规划列表dp[j],dp[j]代表以字符s[j]为结尾的“最长不重复子字符串”的长度。
+ (NSInteger)lengthOfLongestSubstring:(NSArray *)chars;


#pragma mark - 二分查找
+ (NSInteger)searchNums:(NSArray *)nums withTarget:(NSInteger)target;


#pragma mark - 最大子序和（动态规划）
+ (NSInteger)maxSubArray:(NSArray *)nums;


#pragma mark - 接雨水问题
+ (NSInteger)maxWater:(NSArray *)nums;


#pragma mark - 岛屿数量问题
int numIslands(char** grid, int gridSize, int* gridColSize);


#pragma mark - 跳台阶
+ (NSInteger)jumpFloor_recursive:(NSUInteger)number;// 递归

+ (NSInteger)jumpFloor:(NSUInteger)number;          // 非递归

@end

NS_ASSUME_NONNULL_END
