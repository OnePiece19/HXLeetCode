//
//  HXTree.m
//  算法
//
//  Created by HX on 2021/4/1.
//

#import "HXTree.h"

@implementation HXTree

#pragma mark - 遍历二叉树

/*
 树的遍历方式总体分为两类：深度优先搜索（DFS）、广度优先搜索（BFS）；
 常见的 DFS ： 先序遍历、中序遍历、后序遍历；
 常见的 BFS ： 层序遍历（即按层遍历）。
 */

// 先序遍历
- (void)prePrint:(TreeNode *)treeNode {
    NSLog(@"%ld",[treeNode.val integerValue]);
    if (treeNode.left) [self prePrint:treeNode.left];
    if (treeNode.right) [self prePrint:treeNode.right];
    return;
}
// 中序遍历
- (void)midPrint:(TreeNode *)treeNode {
    if (treeNode.left) [self midPrint:treeNode.left];
    NSLog(@"%ld",[treeNode.val integerValue]);
    if (treeNode.right) [self midPrint:treeNode.right];
    return;
}
// 后序遍历
- (void)sufPrint:(TreeNode *)treeNode {
    if (treeNode.left) [self sufPrint:treeNode.left];
    if (treeNode.right) [self sufPrint:treeNode.right];
    NSLog(@"%ld",[treeNode.val integerValue]);
    return;
}
// 层次遍历
- (void)levelOrder:(TreeNode*)treeNode {
    // 1、创建一个可变数组（队列）
    NSMutableArray<TreeNode *>* treeArray = [NSMutableArray array];
    [treeArray addObject:treeNode];

    while (treeArray.count > 0) {
        // 2、遍历结点删除
        TreeNode * treeNode = treeArray.firstObject;
        printf(" %ld ",[treeNode.val integerValue]);
        [treeArray removeObjectAtIndex:0];
        // 3、逐层加入数组
        if (treeNode.left){
            [treeArray addObject:treeNode.left];
        }
        if (treeNode.right){
            [treeArray addObject:treeNode.right];
        }
    }
}
// 之字形层次遍历
- (NSArray<NSArray *>*)zigzagLevelOrder:(TreeNode*)treeNode {
    
    // 1、定义返回的二位可变数组
    NSMutableArray<NSArray *> *res = [NSMutableArray array];
    if (treeNode == nil) return res;
    // 2、定义队列
    NSMutableArray * queue = [NSMutableArray array];
    [queue addObject:treeNode];
    BOOL isOrderLeft = YES; // 定义遍历方向
    while (queue.count > 0) {
        // 3、定义每层数组
        NSMutableArray * level = [NSMutableArray array];
        NSInteger levelCount = queue.count;
        for (int i = 0 ; i<levelCount; i++) {
            // 4、出队列
            TreeNode * outNode = queue.firstObject;
            [queue removeObject:outNode];
            
            if (isOrderLeft) {
                [level addObject:outNode];
            } else {
                [level insertObject:outNode atIndex:0];
            }
            // 5、每层入队列
            if (outNode.left)  [queue addObject:treeNode.left];
            if (outNode.right) [queue addObject:treeNode.right];
        }
        [res addObject:[level copy]];
        isOrderLeft = !isOrderLeft;
    }
    return res;
}

#pragma mark - 二叉树的右视图
// 时间:O(n), 空间:O(n),
- (NSArray *)rightSideView:(TreeNode*)treeNode {
    if (treeNode == nil) return nil;
    NSMutableArray *res = [NSMutableArray array];
    // 1、创建一个可变数组（队列）
    NSMutableArray<TreeNode *>* treeArray = [NSMutableArray array];
    [treeArray addObject:treeNode];
    while (treeArray.count > 0) {
        // 2、取出每层最后一个节点加入返回的数组
        TreeNode * treeNode = treeArray.lastObject;
        [res addObject:treeNode];
        // 3、记录每层的个数
        NSInteger levelCount = treeArray.count;
        for (int i = 0; i < levelCount; i++) {
            // 4、每层出队列
            TreeNode * outNode = treeArray[i];
            [treeArray removeObject:outNode];
            // 5、每层入队列
            if (outNode.left)  [treeArray addObject:treeNode.left];
            if (outNode.right) [treeArray addObject:treeNode.right];
        }
    }
    return [res copy];
}

#pragma mark - 二叉树的深度
- (NSInteger)maxDepth:(TreeNode*)root {
    if (root == nil) return 0;
    NSInteger leftHeight = [self height:root.left];
    NSInteger rightHeight = [self height:root.right];
    return MAX(leftHeight, rightHeight) + 1;
}


#pragma mark - 平衡二叉树
/*
 定义函数height，用于计算二叉树中的任意一个节点 p 的高度：
            0                                       p 是空节点
height(p)={
            max(height(p.left),height(p.right))+1   p 是非空节点
*/

-(BOOL)isBalanced:(TreeNode*)root {
    return [self height:root] >= 0;
}
// 递归 计算二叉树中的任意一个节点 p 的高度
-(NSInteger)height:(TreeNode*)root {
    if (root == nil) return 0;
    // 递归遍历左右子树，然后MAX(leftHeight, rightHeight) + 1;计算高度
    NSInteger leftHeight = [self height:root.left];
    NSInteger rightHeight = [self height:root.right];
    
    if (leftHeight == -1 || rightHeight == -1 || labs(leftHeight - rightHeight) > 1) {
        return -1;
    } else {
        // 选出 左右子树大高的+1
        return MAX(leftHeight, rightHeight) + 1;
    }
}

#pragma mark - 对称二叉树
// 时间:O(n), 空间:O(n),
-(BOOL)isSymmetric_dfs:(TreeNode*)root{
    return [self isMirror:root withTarget:root];
}

// 时间:O(n), 空间:O(n),
-(BOOL)isSymmetric_bfs:(TreeNode*)root {
    NSMutableArray * queue = [NSMutableArray array];
    [queue addObject:root];
    [queue addObject:root];
    while (queue.count > 0) {
        TreeNode* t1 = queue.firstObject;
        [queue removeObject:t1];
        TreeNode* t2 = queue.firstObject;
        [queue removeObject:t2];
        if (t1 == nil && t2 == nil) continue;
        if (t1 == nil || t2 == nil) return NO;
        if (t1.val != t2.val) return NO;
        [queue addObject:t1.left];
        [queue addObject:t2.right];
        [queue addObject:t1.right];
        [queue addObject:t2.left];
    }
    return YES;
}

#pragma mark - 二叉树的镜像
/*
 例如输入：

      1
    /   \
   2     3
  / \   / \
 4   5 6   7
 镜像输出：
      1
    /   \
   3     2
  / \   / \
 5   4 7   6
 */
- (TreeNode *)mirrorTree:(TreeNode *)root {
    if (root == NULL) return root;
    
    TreeNode * left = [self mirrorTree:root.left];
    TreeNode * right = [self mirrorTree:root.right];
    
    root.left = right;
    root.right = left;
    
    return root;
}

-(BOOL)isMirror:(TreeNode*)t1 withTarget:(TreeNode*)t2 {
    if (t1 == nil && t2 == nil) return YES;
    if (t1 == nil || t2 == nil) return NO;
    
    return (t1.val == t2.val)
    && [self isMirror:t1.right withTarget:t2.left]
    && [self isMirror:t1.left withTarget:t2.right] ;
}

@end
