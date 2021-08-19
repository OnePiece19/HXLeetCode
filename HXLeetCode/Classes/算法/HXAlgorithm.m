//
//  HXAlgorithm.m
//  HXProject
//
//  Created by hx on 2021/7/30.
//

#import "HXAlgorithm.h"
#import <Foundation/Foundation.h>
#import "HXArray.h"
#import "HXListNode.h"
#import "AFNetworking.h"
@interface HXAlgorithm ()

@end


@implementation HXAlgorithm

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

void testListNode() {
    
}

void testArray() {
    NSArray * nums = @[@(2),@(7),@(11),@(15)];
    // 1、两数之和
    // 暴力
    NSArray * vioArray = [HXArray violenceTwoSum:nums target:9];
    NSLog(@"%@",vioArray);
    // 哈希表
    NSArray * hashArray = [HXArray hashTwoSum:nums target:9];
    NSLog(@"%@",hashArray);
    
    
    //2、合并两个有序数组
    NSArray * mergeNums = @[@(1),@(2),@(3),@(0),@(0),@(0)];
    NSMutableArray * nums1 = [NSMutableArray arrayWithArray:mergeNums];
    NSArray * nums2 = @[@(2),@(5),@(6)];
    [HXArray mergeArray:nums1 firstSize:3 withTarget:nums2 secondSize:3];
    NSLog(@"%@",nums1);
    
    
    //10、最小路径和
    NSArray<NSArray*>* grid = @[@[@(1),@(3),@(1)],
                                @[@(1),@(5),@(1)],
                                @[@(4),@(2),@(1)]];
    NSInteger minPath = [HXArray minPathSum:grid];
    NSLog(@"%zd",minPath);
    
    //
    NSArray * chars = @[@"a",@"b",@"c",@"d",@"a",@"b",@"c",@"b",@"b"];
    NSInteger length = [HXArray lengthOfLongestSubstring:chars];
    NSLog(@"%zd",length);
}

void testSort() {
    
}


@end
