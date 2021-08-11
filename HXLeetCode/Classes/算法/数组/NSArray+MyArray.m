//
//  NSArray+MyArray.m
//  初识枚举器enumerateObjectsUsingBlock
//
//  Created by HX on 2019/12/13.
//  Copyright © 2019 黄雄. All rights reserved.
//

#import "NSArray+MyArray.h"
//#import <AppKit/AppKit.h>
#import <objc/runtime.h>

@implementation NSArray (MyArray)

- (void)enumerateTestBlock:(void (^)(id _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop))enumBlock {
    if (!enumBlock && self.count == 0) return;
    BOOL stop = NO;
    for (int index = 0; index < self.count; index++ ) {
        if (!stop) {
            enumBlock(self[index], index, &stop);
        } else {
            break;
        }
    }
}


//+ (void)mj_enumerateClasses:(MJClassesEnumeration)enumeration {
//    // 1.没有block就直接返回
//    if (enumeration == nil) return;
//    // 2.停止遍历的标记
//    BOOL stop = NO;
//    // 3.当前正在遍历的类
//    Class c = self;
//    // 4.开始遍历每一个类
//    while (c && !stop) {
//        // 4.1.执行操作
//        enumeration(c, &stop);
//        // 4.2.获得父类
//        c = class_getSuperclass(c);
//        if ([MJFoundation isClassFromFoundation:c]) break;
//    }
//}

@end
