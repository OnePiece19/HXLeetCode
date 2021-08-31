//
//  HXListNode.c
//  链表
//
//  Created by HX on 2021/3/31.
//

#import "HXListNode.h"

@interface HXListNode ()

@end

@implementation HXListNode

#pragma mark - 链表打印
//倒序打印链表
int* printListNode(ListNode* head, int* returnSize){
    struct ListNode *p = head;
    *returnSize = 0;
    while (p) {
        p = p->next;
        (*returnSize)++;
    }
    int *ret = (int *)malloc(sizeof(int) * (*returnSize));
    for (int i = *returnSize - 1; i >= 0; i--) {
        ret[i] = head->val;
        head = head->next;
    }
    for (int i = 0; i < *returnSize; i++) {
        printf("%d->",ret[i]);
    }
    return ret;
}
//倒序打印链表--递归
void printListNode_recursive(ListNode* head) {
    if (head == NULL) return;       // 递归结束
    if (head->next != NULL) {       // 递归条件
        printListNode_recursive(head->next); // 递归
    }
    printf("%d-->",head->val);      // 递归代码
}
//倒序打印链表--栈
int* printListNode_stack(ListNode* head, int* returnSize) {
    *returnSize=0;
    if(head==NULL) return 0;
    int stack[10001];
    int top=-1;
    while(head) {//将链表元素压入栈中
        stack[++top]=head->val;
        head=head->next;
    }
    int* res=(int*)malloc(sizeof(int)*(top+1));
    while(top!=-1)//弹栈
        res[(*returnSize)++]=stack[top--];
    return res;
}

#pragma mark - 链表合并
/**
 合并两个有序链表
 
 @param l1 1->2->4
 @param l2 1->3->4
 @return 1->1->2->3->4->4
 */
ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
    if (l1 == NULL) return l2;
    if (l2 == NULL) return l1;
    // 1、新链表的头尾指针
    struct ListNode * head = NULL;
    struct ListNode * tail = NULL;
    // 2、存放提取的结点
    struct ListNode * t = NULL;
    // 遍历两个链表
    struct ListNode * t1 = l1;
    struct ListNode * t2 = l2;
    while (t1 !=NULL && t2!=NULL) {
        // 提取到t
        if (t1->val < t2->val) {
            t =t1;
            t1 = t1->next;
        } else {
            t = t2;
            t2 = t2->next;
        }
        t->next = NULL;
        if (head==NULL) { //新的头
            head = t;
            tail = t;
        } else {          // 插入尾部
            tail->next = t;
            tail = tail->next;
        }
    }
    if (t1==NULL) {
       tail->next = t2;
    }
    if (t2==NULL) {
       tail->next = t1;
    }
   return head;
}


#pragma mark - 删除节点
/**
 @param node 要求被删除的节点
 */
void deleteNode(struct ListNode* node) {
    node->val = node->next->val;
    node->next = node->next->next;
}

/**
 输入: 1->1->2->3->3
 输出: 1->2->3
 */
ListNode* deleteDuplicates(ListNode* head){
    if (head == NULL || head->next == NULL) return head;
    
    ListNode * first = head;
    ListNode * second = head ->next;

    while(first != NULL && second != NULL){
        while(second!=NULL && first->val == second->val ){
            second = second->next;  // 删除元素
        }
        first->next = second;       // 第一指针后移
        first = second;
        if(first!=NULL){
            second = first->next;   // 第二指针后移
        }
    }
    return head;
}

/**
 @param head 头
 @param n n保证是有效的。
 @return 删除倒数结点n的
 
 快慢指针
 */
ListNode* removeNthFromEnd(ListNode* head, int n){
    ListNode* fast = head;
    while(n-- != 0)
        fast = fast->next;      // 第一个指针先移动到整数第N个结点
    if(!fast)
        return head->next;      // 判断空
    
    struct ListNode* slow = head;  // 第二个指针指向头结点，此时两个指针距离为N
    
    while(fast->next != NULL){   // 第一个指针，移动到最后一个结点（此时第二指针指向倒数N）
        slow = slow->next;          // 两个指针同时移动
        fast = fast->next;
    }
    slow->next=slow->next->next;  // 删除结点
    return head;
}
/**
 输入: 1->2->6->3->4->5->6, val = 6
 输出: 1->2->3->4->5
 */
ListNode* removeElements(struct ListNode* head, int val) {
    struct ListNode *p=head, *temp;
    if(head == NULL)
        return head;
    while(head->val==val){
        if(head->next!=NULL) head=head->next;
        else return NULL;
    }
    while(p->next != NULL){
        if(p->next->val == val){
            temp = p->next;
            p->next = p->next->next;
            free(temp);
        }else{
            p = p->next;
        }
    }
    return head;
}

ListNode* removeElements_recursive(ListNode* head, int val) {
    //recursive递归
    if (head == NULL) return head;//递归出口
    head->next = removeElements_recursive(head->next, val);
    if(head->val == val){
        return head->next;
    } else {
        return head;
    }
}
#pragma mark - 中间节点
struct ListNode *findMiddle(struct ListNode *head) {
    struct ListNode *middle = head;
    struct ListNode *runner = head->next;
    while(runner != NULL && runner->next != NULL) {
        middle = middle->next;
        runner = runner->next->next;
    }
    return middle;
}

#pragma mark - 链表反转
// 时间O(n) - 空间O(1)
ListNode* reverseList(ListNode* head) {
    ListNode* pre = nil;
    ListNode* cur = head;
    while (cur) {
        ListNode* next = cur->next;
        cur->next = pre;
        pre = cur;
        cur = next;
    }
    return pre;
}
// 时间O(n) - 空间O(n)
ListNode* reverseList_recursive(ListNode* head) {
    if (head == NULL || head->next == NULL) {
        return head; //返回最后一个节点
    }
    // 递归到(最后一个结点)作为新的头节点
    ListNode * newHead = reverseList_recursive(head->next);
    // 让head后面的节点 转向 指向head
    head->next->next = head;
    head->next = NULL;
    return newHead;
}

/*
 给你这个链表：1->2->3->4->5
 当 k = 2 时，应当返回: 2->1->4->3->5
 当 k = 3 时，应当返回: 3->2->1->4->5
*/
ListNode* reverseKGroup(ListNode* head, int k){
    if (head == nil) return head;
    ListNode* ptr=head;
    // 1、够不够k个一组，不够返回head
    for(int i=0;i<k;i++) {
        if(ptr) {
            ptr=ptr->next;
        }else {
            return head;
        }
    }
    // 2、反转链表（头插法：取出最后一个插入头部）
    ListNode* reHead=head;   // 代已反转（链头）
    ListNode* tail=reHead;   // 代已反转（链尾）
    ptr=tail->next;          // 代表要（插入头的结点）
    for (int i=1;i<k;i++) {     //从第二节点开始遍历
        tail->next=ptr->next;   // 尾结点 指向  后链表
        ptr->next=reHead;       // 反转结点 指向  链头
        reHead=ptr;             // 更新 头结点
        ptr=tail->next;         // 更新 反转结点
    }
    // 3、递归
    tail->next=reverseKGroup(ptr,k);
    return reHead;
}

/**
 说明:
 1 ≤ m ≤ n ≤ 链表长度。

 输入: 1->2->3->4->5->NULL, m = 2, n = 4
 输出: 1->4->3->2->5->NULL
 */
ListNode* reverseBetween(struct ListNode* head, int m, int n){
    int i = 1;
    int x = n-m;
    ListNode start;
    ListNode* pre = &start; // 增加结点
    pre->next = head;
    ListNode* first = head; // 部分反转的头
    ListNode* last;  // 部分反转的头
    ListNode* p;
    while (i<m){
        pre = pre->next;
        first = first->next;
        i++;
    }
    last = first;
    // 结点前移
    for(i = 0; i < x; i++){
        p = last->next;
        pre->next = p;
        last->next = p->next;
        p->next = first;
        first = p;
    }
    return start.next;
}

/*
 给定 1->2->3->4, 你应该返回 2->1->4->3.
 原来的头结点发生了变换,比如被删除了，或者被交换位置了
 建立一个dummy结点
 */
ListNode* swapPairs(struct ListNode* head){
    if(!head || !head->next)   return head;
    // 创建一个新结点，或者 提前执行一次交换1
    ListNode * dummy = (ListNode *)malloc(sizeof(ListNode));
    ListNode * pre = dummy;
    dummy->next = head;

    while (pre->next && pre->next->next) {
        ListNode *a = pre->next;
        ListNode *b = a->next;
        pre->next = b;          // 前驱指针->b
        a->next = b->next;      // a指针指向后续链表
        b->next = a;            // b指针指向a
        pre = pre->next->next;  // 前驱指针后移 两位
    }
    return dummy->next;
}

struct ListNode* swapPairs1(struct ListNode* head){
    if (head == NULL || head->next == NULL) {
        return head;
    }
    struct ListNode* temp1 = head;
    struct ListNode* temp2 = head->next;
    struct ListNode* newHead = temp2;
    while (1) {
        temp1->next = temp2->next;
        temp2->next = temp1;

        if (temp1->next && temp1->next->next) {
            temp1 = temp1->next;
            temp2->next->next = temp1->next;
            temp2 = temp1->next;
        } else {
            break;
        }
    }
    return newHead;
}

#pragma mark - 环形链表
/*
 给定一个链表，判断链表中是否有环。

 @param head 链表头
 @return ture or flase
 */
bool hasCycle(ListNode * head) {
    if(head == nil || head->next == nil) return false;
    ListNode * fast = head;
    ListNode * slow = head;
    while (fast != nil && fast->next != nil && fast->next->next != nil) {
        slow = slow->next;
        fast = fast->next->next;
        if (slow == fast) {
            return true;
        }
    }
    return false;
}

/**
 给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。
 
 解析：设 入环的第一个节点 A , 相交节点B,（head —— A） 的距离是 a；slow 指针在环中走过的距离是b
            slow 指针走过的距离是  a+b , fast 走过的距离是 2(a+b) = a+b+a+b
            结论：1、show 再走 a+b 回到B点，2、走a的距离到达A点
 */
ListNode* detectCycle(ListNode *head) {
    if(head == nil || head->next == nil) return nil;
    struct ListNode * fast = head;
    struct ListNode * slow = head;
    // 快慢指针
    while (fast != NULL && fast->next != NULL && fast->next->next != NULL){
        slow = slow->next;
        fast = fast->next->next;
        if (slow == fast){
            //此时说明有环
            fast = head;
            while(true){
                if (slow == fast){
                    return slow;
                }
                slow = slow->next;
                fast = fast->next;
            }
        }
    }
    return NULL;
}

#pragma mark - 相交链表
/*
 编写一个程序，找到两个单链表相交的起始节点。
 如下面的两个链表：
       a1 -> a2 ↘
                 c1 -> c2 -> c3
 b1 -> b2 -> b3 ↗
 在节点 c1 开始相交。
 解析：在相交结点前，保证步伐一致
 */
ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
     if (headA==NULL || headB == NULL) return NULL;
     struct ListNode *pA = headA;
     struct ListNode *pB = headB;
     // 交换遍历，短长互补
     while (pA != pB){
         pA = (pA == NULL ? headB : pA->next);
         pB = (pB == NULL ? headA : pB->next);
     }
     return pA;
}

ListNode* _Nullable getIntersectionNode_normal(ListNode *headA, ListNode *headB) {
    if (headA == NULL || headB == NULL) return NULL;
    int lenA = 0, lenB = 0;
    struct ListNode * a = headA;
    struct ListNode * b = headB;
    while(a != NULL) {
        lenA ++;
        a = a->next;
    }
    while(b != NULL) {
        lenB ++;
        b = b->next;
    }
    int step;
    a = headA;
    b = headB;
    if (lenA - lenB > 0){
        step = lenA - lenB;
        while (step > 0) {
            a = a ->next;
            step--;
        }
    } else {
        step = lenB - lenA;
        while (step > 0) {
            b = b ->next;
            step--;
        }
    }
    while (a!=NULL && b!=NULL){
        if (a==b) return a;
        a = a->next;
        b = b->next;
    }
    return NULL;
}

/**
 请判断一个链表是否为回文链表
 
 @param head 1->2->2->1 or 1->2->1
 @return return true
 */
bool isPalindrome(struct ListNode* head){
    
    if(head == NULL || head->next == NULL)
        return true;
    //利用快慢指针找到中间结点
    struct ListNode* fast = head;
    struct ListNode* slow = head;
    
    struct ListNode* p = head;
    struct ListNode* pre = p;
    struct ListNode* reHead = NULL;
    
    while(fast != NULL && fast->next != NULL){
        slow = slow->next;
        fast = fast->next->next;
        
        pre = p->next;
        p->next = reHead;
        reHead = p;
        p = pre;
    }
    
    //如果链表长为奇数，slow应该指向中间结点的后一个
    if (fast) {
        slow = slow->next;
    }

    while(slow){
        if(slow->val != reHead->val)
            return false;
        slow = slow->next;
        reHead = reHead->next;
    }
    return true;
}

#pragma mark - 奇偶链表
/**
 输入: 1->2->3->4->5->NULL
 输出: 1->3->5->2->4->NULL
 */
ListNode* oddEvenList(struct ListNode* head){
    
    if(!head || !head->next) return head;
    struct ListNode *odd = head;  //奇数尾节点
    struct ListNode *even = head->next; // 偶数尾节点

    while(even && even->next){
        ListNode *tmp = odd->next;
        odd->next = even->next;
        even->next = even->next->next;
        odd->next->next = tmp;
        even = even->next;
        odd = odd->next;
    }
    return head;
}

#pragma mark - 两数相加
/**
 给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。
 如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
 您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
 输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
 输出：7 -> 0 -> 8
 原因：342 + 465 = 807
 @param l1   链表头，
 @param l2   链表头，
 @return 合并的链表
 */
ListNode* addTwoNumbers(ListNode* l1, ListNode* l2){
    
    struct ListNode * result;
    result = malloc(sizeof(struct ListNode));
    result -> next = NULL;
    struct ListNode * L = result;
    int sum = 0;
    while (l1 != NULL || l2 != NULL || sum != 0) {
        if (l1 != NULL) {
            sum += l1->val;
            l1 = l1->next;
        }
        if (l2 != NULL) {
            sum +=l2->val;
            l2 = l2->next;
        }
        struct ListNode * p = malloc(sizeof(struct ListNode));
        p->next = NULL;
        p->val = sum % 10;
        L->next = p;
        L = L->next;
        sum = sum/10;
    }
    if (l1 != NULL) {
        L->next = l1;
    }
    if (l2 != NULL) {
        L->next = l2;
    }
    result = result ->next;
    return result;
}

#pragma mark - 排序链表
/**
 在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序。 ->归并排序
 */
ListNode *sortList(ListNode *head) {
    if (head == NULL || head->next == NULL){
        return head;
    }
    struct ListNode *middle = findMiddle(head);
    struct ListNode *right = sortList(middle->next);
    middle->next = NULL;
    struct ListNode *left = sortList(head);
    return mergeTwoLists(left, right);
}

@end





