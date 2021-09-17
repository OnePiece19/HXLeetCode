//
//  LRUCache.h
//  算法
//
//  Created by HX on 2021/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRUCache : NSObject

- (instancetype)init:(NSUInteger)limit;

- (id)objectForKey:(NSString *)key;

- (void)setObject:(id)obj forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;


- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
