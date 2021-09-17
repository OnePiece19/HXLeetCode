//
//  HXTree.h
//  算法
//
//  Created by HX on 2021/4/1.
//

#import <Foundation/Foundation.h>

//typedef struct TreeNode{
//    NSInteger val;
//    struct TreeNode * _Nullable left;
//    struct TreeNode * _Nullable right;
//}TreeNode;

@interface TreeNode : NSObject

@property(nonatomic, strong, nonnull) NSNumber * val;

@property(nonatomic, strong, nullable) TreeNode * left;

@property(nonatomic, strong, nullable) TreeNode * right;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HXTree : NSObject

#pragma mark - 遍历二叉树
- (void)prePrint:(TreeNode *)treeNode;    // 先序遍历

- (void)midPrint:(TreeNode *)treeNode;    // 中序遍历

- (void)sufPrint:(TreeNode *)treeNode;    // 后序遍历

- (void)levelOrder:(TreeNode*)treeNode;   // 层次遍历

- (NSArray<NSArray *>*)zigzagLevelOrder:(TreeNode*)treeNode; // 之字形层次遍历?

#pragma mark - 二叉树的右视图
- (NSArray *)rightSideView:(TreeNode*)treeNode;

#pragma mark - 二叉树的深度
- (NSInteger)maxDepth:(TreeNode*)treeNode;

#pragma mark - 平衡二叉树
-(BOOL)isBalanced:(TreeNode*)root;

#pragma mark - 对称二叉树
-(BOOL)isSymmetric_dfs:(TreeNode*)root;  // 深度递归

-(BOOL)isSymmetric_bfs:(TreeNode*)root;  // 广度遍历

#pragma mark - 二叉树的镜像
- (TreeNode *)mirrorTree:(TreeNode *)root;

- (BOOL)isMirror:(TreeNode*)t1 withTarget:(TreeNode*)t2;


#pragma mark - 二叉树中和为某一值的路径

@end

NS_ASSUME_NONNULL_END
