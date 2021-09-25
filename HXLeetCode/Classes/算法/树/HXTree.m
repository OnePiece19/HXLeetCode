//
//  HXTree.m
//  算法
//
//  Created by HX on 2021/4/1.
//

#import "HXTree.h"

@implementation TreeNode

@end


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

#pragma mark - 最近公共祖先
/*
 给定一棵二叉树(保证非空)以及这棵树上的两个节点对应的val值 o1 和 o2，请找到 o1 和 o2 的最近公共祖先节点。
 注：本题保证二叉树中每个节点的val值均不相同。
解题思路
  o1,o2 分别在祖先左右两侧
  祖先是 o1，o2 在祖先左/右侧
  祖先是 o2，o1 在祖先左/右侧
 使用 dfs 深度遍历，如果节点为 o1,o2 中其中一个直接返回，如果节点超过叶子节点也返回
 */
- (NSInteger)lowestCommonAncestor:(TreeNode*)root first:(NSInteger)o1 second:(NSInteger)o2 {
    return [self commonAncestor:root first:o1 second:o2].val;
}

// 返回最近公共 结点
- (TreeNode *)commonAncestor:(TreeNode*)root first:(NSInteger)o1 second:(NSInteger)o2 {
    if (root == NULL || root.val == o1 || root.val == o2) {
        return root;
    }
    TreeNode * left = [self commonAncestor:root.left first:o1 second:o2];   // 返回左侧的o1/o2结点
    TreeNode * right = [self commonAncestor:root.right first:o1 second:o2]; // 返回右侧的o1/o2结点
    if (left == NULL) {     // 都在右侧
        return right;
    }
    if (right == NULL) {    // 都在左侧
        return left;
    }
    return root;            // 都在左右两侧
}

#pragma mark - 重建二叉树
/*
 前序序列{1,2,4,7,3,5,6,8} = pre
 中序序列{4,7,2,1,5,3,8,6} = in
 */
- (TreeNode *)reConstructBinaryTree:(NSArray *)preArray inArray:(NSArray *)inArray {
    if (preArray.count == 0 || inArray.count == 0) {
        return nil;
    }
    TreeNode * root = [[TreeNode alloc] init];
    root.val = preArray[0];
    for (int i = 0; i < inArray.count; i++) {
        if ([inArray[i] integerValue] == [preArray[0] integerValue]) {
            // 左子树，注意 copyOfRange 函数，左闭右开
            NSArray *subLeftPre = [preArray subarrayWithRange:NSMakeRange(1, i+1)];
            NSArray *subLeftIn = [inArray subarrayWithRange:NSMakeRange(0, i)];

            root.left = [self reConstructBinaryTree:subLeftPre inArray:subLeftIn];
            // 右子树，注意 copyOfRange 函数，左闭右开
            NSArray *subRightPre = [preArray subarrayWithRange:NSMakeRange(i+1, preArray.count - i)];
            NSArray *subRightIn = [inArray subarrayWithRange:NSMakeRange(i+1, inArray.count - i)];

            root.right = [self reConstructBinaryTree:subRightPre inArray:subRightIn];
            break;
        }
    }
    return root;
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

#pragma mark - 合并二叉树
/*
 已知两颗二叉树，将它们合并成一颗二叉树。合并规则是：都存在的结点，就将结点值加起来，否则空的位置就由另一个树的结点来代替。
 */
- (TreeNode *)mergeTrees:(TreeNode *)t1 withTree:(TreeNode *)t2 {
    if (t1 == NULL) return t2;
    if (t2 == NULL) return t1;
    
    t1.val = @([t1.val integerValue] + [t2.val integerValue]);
    
    t1.left = [self mergeTrees:t1.left withTree:t2.left];
    t1.right = [self mergeTrees:t1.right withTree:t2.right];
    return t1;
}

@end
