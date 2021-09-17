//
//  HXArray.m
//  算法
//
//  Created by HX on 2021/3/29.
//

#import "HXArray.h"

#define min(a,b) ((a<b) ? a : b)
#define Min(a,b) (((a) < (b)) ? (a) : (b))  //比较好一点
#define Max(a,b) ((a>b) ? a : b)

@implementation HXArray

#pragma mark - 两数之和
// 时间复杂度是O(N2)，空间复杂度是O(1);
+(NSArray*)violenceTwoSum:(NSArray*)nums target:(int)target{
    // 注意遍历到倒数 第二个
    for (int i = 0 ; i < nums.count-1 ; i ++) {
        int num = [nums[i] intValue];
        // 从i的后一位开始遍历
        for (int j = i + 1; j< nums.count ; j ++) {
            if ([nums[j] intValue] == target - num) {
                return @[@(i),@(j)];
            }
        }
    }
    return nil;
}

// 解法2：查找表发
// 时间复杂度是O(n)，控件复杂度是O(n);
/*
 -遍历的的同时，记录一些信息，以省去一层循环，这是”以控件换时间“的想法
 -需要记录已经遍历过的数值和它对应的下标，可以借助查找表
 -哈希表
 */
+(NSArray*)hashTwoSum:(NSArray*)nums target:(int)target{
    // 定义hash表<num[i], index>
    NSMutableDictionary<NSNumber *, NSNumber *> *map = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < nums.count; i++) {
        // 在哈希表中查找key是否存在
        NSNumber * numKey = @(target - [nums[i] intValue]);
        if (map[numKey]) {
            return @[map[numKey], @(i)];
        }
        [map setObject:@(i) forKey:nums[i]];
    }
    return nil;
}


#pragma mark - 合并两个有序数组
+ (void)mergeArray:(NSMutableArray *)numsFirst firstSize:(NSInteger)m
           withTarget:(NSArray *)numsSecond secondSize:(NSInteger)n {
    NSInteger indexF = m - 1;   // 数组1的倒叙 索引值
    NSInteger indexS = n - 1;   // 数组2的倒叙 索引值
    NSInteger indexTail = m+n-1;// 数组1的倒叙 插入索引
    
    NSNumber * cur;             // 当前比较所得数值
    while (indexF >= 0 || indexS >= 0) {
        if (indexF == -1) {
            cur = numsSecond[indexS--];
        } else if(indexS == -1) {
            cur = numsFirst[indexF--];
        } else if ([numsFirst[indexF] intValue] > [numsSecond[indexS] intValue]){
            cur = numsFirst[indexF--];
        } else {
            cur = numsSecond[indexS--];
        }
        numsFirst[indexTail--] = cur;
    }
}
#pragma mark - 螺旋矩阵

#pragma mark - 斐波那契数列
+ (NSInteger)fib:(NSInteger)n {
    int a = 0;
    int b = 1;
    int sum;
    for(int i = 0; i < n; i++){
        sum = (a + b);
        a = b;
        b = sum;
    }
    return a;
}

+ (NSInteger)fib_recursive:(NSInteger)n {
    if (n <= 2) {
        return n;
    }
    return [self fib_recursive:n] * [self fib_recursive:(n-1)];
}

#pragma mark - 累加求和

+ (NSInteger)sum:(NSInteger)n{
    if (n <= 0) {
        return 0;
    }
    return n + [self sum:n];
}

#pragma mark - 重建二叉树

//NSMutableDictionary *indexMap;
//
//+ (TreeNode *)buildTreePreodrder:(NSArray *)preorder withInorder:(NSArray *)inorder {
//    // 构造哈希映射，帮助我们快速定位根节点
//    indexMap = [NSMutableDictionary dictionary];
//    for (int i = 0; i<preorder.count; i++) {
//        [indexMap setObject:preorder[i] forKey:@(i)];
//    }
//    return [self myBuildTreePreodrder:preorder withInorder:inorder
//                         preorderLeft:0 preOrderRight:preorder.count-1
//                          inorderLeft:0 inorderRight:inorder.count-1];
//}
//
//+ (TreeNode *)myBuildTreePreodrder:(NSArray *)preorder withInorder:(NSArray *)inorder
//                      preorderLeft:(NSUInteger)preLeft preOrderRight:(NSUInteger)preRight
//                       inorderLeft:(NSUInteger)inLeft inorderRight:(NSUInteger)inRight {
//    if (preLeft > preRight) return nil;
//    // 前序遍历中的第一个节点就是根节点
//    NSUInteger preorder_root = preLeft;
//    // 在中序遍历中定位根节点
//    NSUInteger inorder_root = [indexMap[preorder[preorder_root]] integerValue];
//    // 先把根节点建立出来
//    TreeNode * root = [TreeNode new];
//    // 得到左子树中的节点数目
//    NSUInteger size_left_subtree = inorder_root - inLeft;
//    // 递归地构造左子树，并连接到根节点
//    // 先序遍历中「从 左边界+1 开始的 size_left_subtree」个元素就对应了中序遍历中「从 左边界 开始到 根节点定位-1」的元素
//    root.left = [self myBuildTreePreodrder:preorder withInorder:inorder preorderLeft:preLeft + 1 preOrderRight:preLeft + size_left_subtree inorderLeft:inLeft inorderRight:inorder_root - 1];
//    
//    // 递归地构造右子树，并连接到根节点
//    // 先序遍历中「从 左边界+1+左子树节点数目 开始到 右边界」的元素就对应了中序遍历中「从 根节点定位+1 到 右边界」的元素
//    root.right = [self myBuildTreePreodrder:preorder withInorder:inorder preorderLeft:preLeft+size_left_subtree+1 preOrderRight:preRight inorderLeft:inorder_root+1 inorderRight:inRight];
//    return root;
//}


#pragma mark - 股票（一次交易）
// 时间复杂度O(n),空间复杂度O(1);
+ (NSInteger)maxProfit:(NSArray *)prices {
    if(prices.count <= 1) return 0;
    NSInteger minPrice = NSIntegerMax;  // 记录最小价格
    NSInteger maxProfit = 0;            // 记录最大利润
    for (int i = 0; i < prices.count; i++) {
        // 寻找最小值
        if ([prices[i] integerValue] < minPrice) {
            minPrice = [prices[i] integerValue] ;
        }
        // 计算最大利润
        if ([prices[i] integerValue] - minPrice > maxProfit) {
            maxProfit = [prices[i] integerValue] - minPrice;
        }
    }
    return maxProfit;
}

#pragma mark - 求众数

+ (NSInteger)majorityElement:(NSArray *)nums {
    int count = 1; //记录数字个数
    NSNumber * num = nums[0];
    for (int i = 1; i<nums.count; i++) {
        if (num == nums[i]) {
            count++;
        }else {
            count--;
            if (count == 0)
                num = nums[i+1];
        }
    }
    return [num integerValue];
}

#pragma mark - 最小路径和
// 解法：动态规划
/*
 当i>0且j=0时，dp[i][0] = [dp[i-1][0] + grid[i][0];
 当i=0且j>0时，dp[0][j] = [dp[0][j-1] + grid[0][j];
 当i>0且j>0时，dp[i][j] = MIN(dp[i-1][j],dp[i][j-1]) + grid[i][j];
 */
+ (NSInteger)minPathSum:(NSArray<NSArray *>*)grid {
    NSUInteger rows = grid.count;
    NSUInteger cols = grid[0].count;
    // 创建一个动态数组/Users/hx/Desktop/独孤九剑/03 | 算法/算法/算法/HXArray.m
    NSMutableArray *dp = [NSMutableArray arrayWithCapacity:rows];
    for (int i = 0; i<rows; i++) {
        NSMutableArray * temp = [NSMutableArray arrayWithCapacity:cols];
        [dp addObject:temp];
    }
    dp[0][0] = grid[0][0];
    // 第一列计算
    for (int i = 1; i<rows; i++) {
        dp[i][0] = @([dp[i-1][0] integerValue] + [grid[i][0] integerValue]);
    }
    // 第一行计算
    for (int j = 1; j<cols; j++) {
        dp[0][j] = @([dp[0][j-1] integerValue] + [grid[0][j] integerValue]);
    }
    
    for (int i = 1; i<rows; i++) {
        for (int j = 1; j<cols; j++) {
            dp[i][j] = @(Min([dp[i-1][j] integerValue],[dp[i][j-1] integerValue]) + [grid[i][j] integerValue]);
        }
    }
    return [dp[rows - 1][cols - 1] integerValue];
}

#pragma mark - 缺失的数字
// 时间复杂度O(logN)： 二分法为对数级别复杂度
// 空间复杂度O(1)： 几个变量使用常数大小的额外空间。
+ (NSInteger)missingNumber:(NSArray *)nums {
    NSInteger i = 0;
    NSInteger j = nums.count - 1;
    while (i < j) {
        NSInteger m = (i+j)/2;
        if ([nums[m] integerValue] == m) {
            i = m + 1;
        }else{
            j = m - 1;
        }
    }
    return i;
}

#pragma mark - 最小的k个数
+ (NSArray *)getLeastNumbers:(NSArray *)nums withNums:(NSInteger)k {
    return nil;
}
#pragma mark - 寻找第K大
// 有一个整数数组，请你根据快速排序的思路，找出数组中第 大的数。
+ (NSInteger)findKth:(NSArray *)nums targetNumL:(NSInteger)K{
    
    return [self findK:nums left:0 right:nums.count-1 target:K];
}

+ (NSInteger)findK:(NSMutableArray *)nums left:(NSInteger)left right:(NSInteger)right target:(NSInteger)K{
    if (left < right) {
        NSInteger index = [self fastSortOnce:nums left:left right:right];
        
        if (index = K - 1) {
            return nums[index];
        } else if (index < K - 1){
            return [self findK:nums left:index+1 right:right target:K]; // 第K大的数在 右边
        } else if (index > K - 1){
            return [self findK:nums left:left right:index-1 target:K];  // 第K大的数在 左边
        }
    }
    return -1;
}

// 返回一次快速排序的key索引
+ (NSInteger)fastSortOnce:(NSMutableArray *)nums left:(NSInteger)left right:(NSInteger)right {
    NSInteger key = [nums[left] integerValue];
    while (left < right) {
        // 首先从右边right开始查找比基准数小的值
        while (left < right && nums[right] < key) {
            right--;
        }
        nums[left] = nums[right];
        //开始从左边left开始查找比基准数大的值
        while (left < right && nums[left] > key) {
            left++;
        }
        nums[right] = nums[left];
    }
    nums[left] = @(key);
    return left; // 返回一次的key的索引
}

#pragma mark - 数组中只出现一次的数（其它数出现k次）
+ (NSInteger)foundOnceNumber:(NSArray *)nums {
    // 定义hash表<num[i], index>
    NSMutableDictionary<NSNumber *, NSNumber *> *map = [[NSMutableDictionary alloc]init];
    for (NSNumber * num in nums) {
        if (map[num]) {
            NSInteger count = [map[num] integerValue];
            [map setObject:num forKey:@(count+1)];
        } else {
            [map setObject:num forKey:@(1)];
        }
    }
    
    for (NSNumber * num in map.allKeys) {
        if ([map[num] integerValue] == 1) {
            return [map[num] integerValue];
        }
    }
    return 0;
}

#pragma mark - 排序

// 冒泡排序
+(NSArray *)sortWithBubble:(NSMutableArray *)srcArray{
    NSInteger i,j;
    NSNumber * tmp;
    NSInteger flag = 1;  //加入一个标志位，可以使冒泡排序的算法最优时间复杂为O(n)
    if (1 >= srcArray.count)
        return srcArray;
    for (i = srcArray.count - 1; i > 0 ; i-- , flag = 1) {
        for (j = 0; j < i; j++) {
            if ([srcArray[j] integerValue] > [srcArray[j+1] integerValue]) {
                tmp = srcArray[j+1];
                srcArray[j+1] = srcArray[j];
                srcArray[j] = tmp;
                flag = 0;
            }
        }
        if (flag)
            break;
    }
    return srcArray;
}
// 快速排序
+ (void)fastSort:(NSMutableArray *)srcArray left:(NSInteger)low right:(NSInteger)high {
    // 递归返回条件
    if (low >= high) {
        return;
    }
    NSInteger i = low;
    NSInteger j = high;
    NSInteger key = [srcArray[low] integerValue];
    
    while (i < j) {
        /**** 1、首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [srcArray[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        srcArray[i] = srcArray[j];
        
        /**** 2、当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [srcArray[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        srcArray[j] = srcArray[i];
    }
    //3、将基准数放到正确位置
    srcArray[i] = @(key);
    [self fastSort:srcArray left:low right:i-1];
    
    [self fastSort:srcArray left:i+1 right:high];
}

#pragma mark - 最长不含重复字符的子字符串
/*
 1、哈希表dic 统计： 指针j 遍历字符s ，哈希表统计字符s[j] 最后一次出现的索引 。
 2、更新左指针i ： 根据上轮左指针i 和dic[s[j]] ，每轮更新左边界i ，保证区间[i+1,j] 内无重复字符且最大。
 */
+ (NSInteger)lengthOfLongSubString:(NSArray *)chars {
    // 定义hash表<chars[i], 最后一次的索引>
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    // 记录最长子字符串的长度
    NSInteger maxLength = 0;
    // 记录左窗口边界  相同字符  的最大索引位置
    int left = 0;
    for (int right = 0; right < chars.count; right++) {
        if (dict[chars[right]]) {
            left = MAX(left, [dict[chars[right]] intValue]); // 与hash表比较 最大的左边界
        }
        [dict setObject:@(right) forKey:chars[right]];
        
        maxLength = MAX(maxLength, right-left+1);
    }
    return maxLength;
}

#pragma mark - 二分查找
// 时间复杂度：O(logN)。空间复杂度：O(1)。
+(NSInteger)searchNums:(NSArray *)nums withTarget:(NSInteger)target {
    NSInteger mid;
    NSInteger left = 0;
    NSInteger right = nums.count - 1;
    
    while (left <= right) {
        mid = left + (right -left)/2;
        if ([nums[mid] integerValue] == target) {
            return mid;
        }
        if ([nums[mid] integerValue] > target) {
            right = mid - 1;
        }else {
            left = mid + 1;
        }
    }
    return -1;
}


#pragma mark - 最大子序和（动态规划）
+ (NSInteger)maxSubArray:(NSArray *)nums {
    // 记录最大和
    NSInteger sum = [nums[0] integerValue];
    NSInteger subCount = [nums[0] integerValue];
    
    for (int i = 1; i < nums.count; i++) {
        if (subCount < 0) {
            // 为负数时，舍弃
            subCount = [nums[i] integerValue];
        } else {
            subCount = subCount + [nums[i] integerValue];
        }
        // 与记录的最大和比较
        if (subCount > sum) {
            sum = subCount;
        }
    }
    return sum;
}


#pragma mark - 接雨水问题
/*
 给定一个整形数组arr，已知其中所有的值都是非负的，将这个数组看作一个柱子高度图，计算按此排列的柱子，下雨之后能接多少雨水。
 输入：[3,1,2,5,2,4]  返回 5
 思路：双指针法
 */
+ (NSInteger)maxWater:(NSArray *)nums {
    // 数据校验
    if (nums.count <= 2) {
        return 0;
    }
    NSInteger res = 0;  // 雨水量
    NSUInteger left = 0;
    NSUInteger right = nums.count - 1;
    // 取低的为边界
    NSInteger minBondary = Min([nums[left] intValue], [nums[right] intValue]);
    
    while (left < right) {
        if (nums[left] < nums[right]) {
            left++;
            // 如果当前边界小于边界，则可以装水
            if ([nums[left] intValue] < minBondary) {
                res =res + (minBondary - [nums[left] intValue]);
            } else {
                minBondary = Min([nums[left] intValue], [nums[right] intValue]);
            }
        } else {
            right--;
            if ([nums[right] intValue] < minBondary) {
                res =res + (minBondary - [nums[right] intValue]);
            } else {
                minBondary = Min([nums[left] intValue], [nums[right] intValue]);
            }
        }
    }
    return res;
}

#pragma mark - 跳台阶
/*
 一只青蛙一次可以跳上1级台阶，也可以跳上2级。求该青蛙跳上一个  级的台阶总共有多少种跳法
 题解：
 当n等于1的时候，只需要跳一次即可，只有一种跳法，记f(1)=1
 当n等于2的时候，可以先跳一级再跳一级，或者直接跳二级，共有2种跳法，记f(2)=2
 当n等于3的时候，他可以从一级台阶上跳两步上来，也可以从二级台阶上跳一步上来，所以总共有f(3)=f(2)+f(1)；
 
 */
+ (NSInteger)jumpFloor_recursive:(NSUInteger)number {
    if (number <= 1)    return 1;
    if (number < 3)     return number;
    return JumpFloor(number - 1) + JumpFloor(number - 2);
}
+ (NSInteger)jumpFloor:(NSUInteger)number {
    if (number <= 2) {
        return number;
    }
    NSInteger first = 1, second = 2, sum = 0;
    while (number-- > 2) {
        sum = first + second;
        first = second;
        second = sum;
    }
    return sum;
}

@end

