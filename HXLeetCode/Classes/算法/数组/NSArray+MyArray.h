//
//  NSArray+MyArray.h
//  初识枚举器enumerateObjectsUsingBlock
//
//  Created by HX on 2019/12/13.
//  Copyright © 2019 黄雄. All rights reserved.
//

//#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

typedef void (^MJClassesEnumeration)(Class _Nullable c, BOOL * _Nullable stop);

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (MyArray)

//这里唯一需要注意就是Block内传入的一个bool类型的指针参数BOOL *stop,是为了外部能在同一内存地址上修改内部实现中的变量stop的值，来实现跳出循环的功能
- (void)enumerateTestBlock:(void (^)(id _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop))enumBlock;


//遍历所有的类,直到遇到Foundation类时跳出循环
//+ (void)mj_enumerateClasses:(MJClassesEnumeration)enumeration;


@end

NS_ASSUME_NONNULL_END
