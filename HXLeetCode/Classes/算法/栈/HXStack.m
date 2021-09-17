//
//  HXStack.m
//  HXLeetCode
//
//  Created by HX on 2021/9/12.
//

#import "HXStack.h"
#import "Stack.h"

@implementation HXStack

/*
 给出一个仅包含字符'(',')','{','}','['和']',的字符串，判断给出的字符串是否是合法的括号序列
 括号必须以正确的顺序关闭，"()"和"()[]{}"都是合法的括号序列，但"(]"和"([)]"不合法
 */
+ (BOOL)isValid:(NSString *)str {
    // 奇数不符合
    if (str.length % 2 == 1) return false;
    Stack * stack = [Stack new];
    for (int i = 0; i < str.length; i++) {
        // 字符
        unichar s = [str characterAtIndex:i];
        
        if (s =='(' || s == '{' || s == '[') {
            // 入栈
            NSNumber * num = [NSNumber numberWithChar:s];
            [stack push:num];
        } else {
            // 出栈比较
            NSNumber * num = [stack popObj];
            unichar pops = [num charValue];
            if (s == ')' && pops != '(') return false;
            if (s == ']' && pops != '[') return false;
            if (s == '}' && pops != '{') return false;
        }
    }
    if ([stack isEmpty]) return YES;
        else return NO;
}



@end
