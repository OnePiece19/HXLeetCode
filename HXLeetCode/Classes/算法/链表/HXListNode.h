//
//  HXListNode.h
//  链表
//
//  Created by HX on 2021/3/31.
//

#import <Foundation/Foundation.h>

// 定义一个链表
typedef struct ListNode{
    int val;
    struct ListNode * _Nullable next;
}ListNode;

//@interface ListNode : NSObject
//
//@property (nonatomic, assign) NSInteger val;
//
//@property (nonatomic, strong) ListNode * _Nullable next;
//
//@end


NS_ASSUME_NONNULL_BEGIN

@interface HXListNode : NSObject

#pragma mark - 链表打印
int* printListNode(ListNode* head, int* returnSize);        //倒序打印链表

void printListNode_recursive(ListNode* head);               //倒序打印链表--递归

int* printListNode_stack(ListNode* head, int* returnSize);  //倒序打印链表--栈


#pragma mark - 链表合并
ListNode* mergeTwoLists(ListNode* l1, ListNode* l2);// 有序链表合并


#pragma mark - 删除节点
void deleteNode(struct ListNode* node);                     // 删除节点node

ListNode* deleteDuplicates(ListNode* head);                 // 删除重复节点

ListNode* removeNthFromEnd(struct ListNode* head, int n);   // 删除倒数第n个节点

ListNode* removeElements(struct ListNode* head, int val);   // 删除元素

ListNode* removeElements_recursive(ListNode* head, int val);// 删除元素--递归


#pragma mark - 中间节点
ListNode *findMiddle(ListNode *head);


#pragma mark - 链表反转
ListNode* reverseList(ListNode* head);                  // 链表反转

ListNode* reverseList_recursive(ListNode* head);        // 链表反转--递归

ListNode* reverseKGroup(ListNode* head, int k);         // 链表反转--k个元素

ListNode* reverseBetween(ListNode* head, int m, int n); // 链表翻转--m到n

ListNode* swapPairs(ListNode* head);                    // 链表反转--两两反转

ListNode* _Nullable swapPairs1(ListNode* head);         // 链表反转--两两反转

#pragma mark - 环形链表
bool hasCycle(ListNode * head);                     // 是否有环

ListNode* _Nullable detectCycle(ListNode *head);    // 入环节点

#pragma mark - 相交链表
ListNode *getIntersectionNode(ListNode *headA, ListNode *headB);        // 相交链表--相交点

ListNode *getIntersectionNode_normal(ListNode *headA, ListNode *headB); // 相交链表--相交点

#pragma mark - 回文链表
bool isPalindrome(ListNode* head);

#pragma mark - 奇偶链表
ListNode* oddEvenList(struct ListNode* head);


#pragma mark - 链表相加
ListNode* addTwoNumbers(ListNode* l1, ListNode* l2);


#pragma mark - 排序链表
ListNode *sortList(ListNode *head);



@end

NS_ASSUME_NONNULL_END
