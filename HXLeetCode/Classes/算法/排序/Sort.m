//
//  Sort.m
//  sort_排序
//
//  Created by HX on 2019/12/13.
//  Copyright © 2019 HX. All rights reserved.
//

#import "Sort.h"

@implementation Sort


#pragma mark - 1、冒泡排序
/**
 依次比较相邻两元素，若前一元素大于后一元素则交换之，直至最后一个元素即为最大；
 然后重新从首元素开始重复同样的操作，直至倒数第二个元素即为次大元素；
 依次类推。如同水中的气泡，依次将最大或最小元素气泡浮出水面。
 
 时间复杂度：O(N2) 　　稳定性：稳定
 */
void bubbleSort(int * nums, int numsSize) {
    int i, j;
    for (i = 0; i < numsSize-1; i++) {
        for (j = 0; j < numsSize-i-1; j++) {
            if (nums[j] > nums[j+1]) {
                int tmp = nums[j];
                nums[j] = nums[j+1];
                nums[j+1] = tmp;
            }
        }
    }
}

#pragma mark - 2、选择排序
/**
 首先初始化最小元素索引值为首元素，依次遍历待排序数列，若遇到小于该最小索引位置处的元素则刷新最小索引为该较小元素的位置，直至遇到尾元素，结束一次遍历，并将最小索引处元素与首元素交换；然后，初始化最小索引值为第二个待排序数列元素位置，同样的操作，可得到数列第二个元素即为次小元素；以此类推。

 时间复杂度：O(N2) 　　稳定性：不稳定
 */
void selectSort(int *nums, int numsSize) {
    int i,j,minIndex,m;
    for(i = 0; i < numsSize-1; i++) {
        minIndex = i;//查找最小值
        for(j = i+1; j < numsSize; j++) {
            if(nums[minIndex] > nums[j]) {
                minIndex = j;
            }
        }
        if(minIndex != i) {
            m = nums[minIndex];
            nums[minIndex] = nums[i];
            nums[i] = m;
        }
    }
}

#pragma mark - 3、快速排序
/**
 类似于选择排序的定位思想）选一基准元素，依次将剩余元素中小于该基准元素的值放置其左侧，大于等于该基准元素的值放置其右侧；
 然后，取基准元素的前半部分和后半部分分别进行同样的处理；
 以此类推，直至各子序列剩余一个元素时，即排序完成（类比二叉树的思想，from up to down）

 时间复杂度：O(NlogN) 　　稳定性：不稳定
 */
void quickSort(int *nums, int left, int right) {
    if (left >= right) return;
    int i = left;
    int j = right;
    int key = nums[left];
    /*控制在当组内寻找一遍*/
    while(i < j) {
        while(i < j && key <= nums[j]) {
            j--;/*向前寻找*/
        }
        nums[i] = nums[j];
        while(i < j && key >= nums[i]) {
            i++;
        }
        nums[j] = nums[i];
    }
    nums[i] = key;/*当在当组内找完一遍以后就把中间数key回归*/
    quickSort(nums, left, i - 1);
    quickSort(nums, i + 1, right);
}

#pragma mark - 4、插入排序
/**
 数列前面部分看为有序，依次将后面的无序数列元素插入到前面的有序数列中，初始状态有序数列仅有一个元素，即首元素。在将无序数列元素插入有序数列的过程中，采用了逆序遍历有序数列，相较于顺序遍历会稍显繁琐，但当数列本身已近排序状态效率会更高。
 
 时间复杂度：O(N2) 　　稳定性：稳定
 */
void insertSort(int *nums, int numsSize) {
    int i,j;
    int temp;
    for(i = 1; i < numsSize; i++) {
        temp=nums[i];
        j=i-1;
        //与已排序的数逐一比较，大于temp时，该数移后
        while((j >= 0)&&(nums[j]>temp)) {
            nums[j+1] = nums[j];
            j--;
        }
        //存在大于temp的数
        if(j != i-1) nums[j+1]=temp;
    }
}

#pragma mark - 5、堆排序
/*
* (最大)堆的向下调整算法
*
* 注：数组实现的堆中，第N个节点的左孩子的索引值是(2N+1)，右孩子的索引是(2N+2)。
*     其中，N为数组下标索引值，如数组中第1个数对应的N为0。
*
* 参数说明：
*     a -- 待排序的数组
*     start -- 被下调节点的起始位置(一般为0，表示从第1个开始)
*     end   -- 截至范围(一般为数组中最后一个元素的索引)
*/
void maxheap_down(int a[], int start, int end) {
    int c = start;            // 当前(current)节点的位置
    int l = 2*c + 1;          // 左(left)孩子的位置
    int tmp = a[c];           // 当前(current)节点的大小
    for (; l <= end; c=l,l=2*l+1) {
        // "l"是左孩子，"l+1"是右孩子
        if ( l < end && a[l] < a[l+1])
            l++;        // 左右两孩子中选择较大者，即m_heap[l+1]
        if (tmp >= a[l])
            break;      // 调整结束
        else {// 交换值
            a[c] = a[l];
            a[l]= tmp;
        }
    }
}

/*
 * 堆排序(从小到大)
 *
 * 参数说明：
 *     a -- 待排序的数组
 *     n -- 数组的长度
 */
void heapSort(int a[], int n) {
    int i;

    // 从(n/2-1) --> 0逐次遍历。遍历之后，得到的数组实际上是一个(最大)二叉堆。
    for (i = n / 2 - 1; i >= 0; i--)
        maxheap_down(a, i, n-1);

    // 从最后一个元素开始对序列进行调整，不断的缩小调整的范围直到第一个元素
    for (i = n - 1; i > 0; i--) {
        // 交换a[0]和a[i]。交换后，a[i]是a[0...i]中最大的。
        swap(a[0], a[i]);
        // 调整a[0...i-1]，使得a[0...i-1]仍然是一个最大堆。
        // 即，保证a[i-1]是a[0...i-1]中的最大值。
        maxheap_down(a, 0, i-1);
    }
}

#pragma mark - 6、希尔排序
/**
 插入排序的改进版。为了减少数据的移动次数，在初始序列较大时取较大的步长，通常取序列长度的一半，此时只有两个元素比较，交换一次；之后步长依次减半直至步长为1，即为插入排序，由于此时序列已接近有序，故插入元素时数据移动的次数会相对较少，效率得到了提高。

 时间复杂度：通常认为是O(N3/2) ，未验证　　稳定性：不稳定
 */
//根据当前增量进行插入排序
void shellInsert(int array[],int n,int dk){
    int i,j,temp;
    for(i=dk;i<n;i++)//分别向每组的有序区域插入
    {
        temp=array[i];
        for(j=i-dk;(j>=i%dk)&&array[j]>temp;j-=dk)//比较与记录后移同时进行
            array[j+dk]=array[j];
        if(j!=i-dk)
            array[j+dk]=temp;//插入
    }
}
 
//计算Hibbard增量
int dkHibbard(int t,int k){
    return (int)(pow(2,t-k+1)-1);
}
 
//希尔排序
void shellSort(int array[],int n,int t){
    void shellInsert(int array[],int n,int dk);
    int i;
    for(i=1;i<=t;i++)
        shellInsert(array,n,dkHibbard(t,i));
}

// OC代码实现
-(NSArray *)sortWithBubble:(NSMutableArray *)srcArray{
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

+ (void)fastSort:(NSMutableArray *)srcArray left:(NSInteger)low right:(NSInteger)high {
    
    if (low >= high) {
        return;
    }
    NSInteger i = low;
    NSInteger j = high;
    NSInteger key = [srcArray[low] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [srcArray[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        srcArray[i] = srcArray[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [srcArray[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        srcArray[j] = srcArray[i];
    }
    //将基准数放到正确位置
    srcArray[i] = @(key);
    [self fastSort:srcArray left:low right:i-1];
    
    [self fastSort:srcArray left:i+1 right:high];
    NSLog(@"%@",srcArray);
}




@end
