//
//  Sort.h
//  sort_排序
//
//  Created by HX on 2019/12/13.
//  Copyright © 2019 HX. All rights reserved.
//

#import <Foundation/Foundation.h>

#define swap(a,b) (a^=b,b^=a,a^=b)

/*


 排序算法共有八大类，即冒泡排序、选择排序、快速排序、插入排序、希尔排序、归并排序、基数排序以及堆排序等
 
 时间复杂度：描述该算法在处理大量数据时，总的来说其时间效率的参考；
 稳定性：描述算法对原始序列处理前后，该序列相等大小的元素前后位置是否发生改变

 　　两个常用的函数：1、获取数组最大元素值； 2、交换两个整形元素。代码如下：
 */

NS_ASSUME_NONNULL_BEGIN

@interface Sort : NSObject

// 1、冒泡排序
-(NSArray *)sortWithBubble:(NSMutableArray *)srcArray;

// 快速排序
+ (void)fastSort:(NSMutableArray *)srcArray left:(NSInteger)low right:(NSInteger)high;

@end

NS_ASSUME_NONNULL_END
