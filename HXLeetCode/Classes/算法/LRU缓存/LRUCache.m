//
//  LRUCache.m
//  算法
//
//  Created by HX on 2021/4/1.
//

#import "LRUCache.h"
// 封装元素
@interface _Element : NSObject

@property (nonatomic, readonly, strong) NSString* key;

@property (nonatomic, strong) id obj;

- (instancetype)initObject:(id)obj forKey:(NSString*)key;

@end

@implementation _Element

- (instancetype)initObject:(id)obj forKey:(NSString*)key {
    if (self = [super init]) {
        _key = key;
        _obj = obj;
    }
    return self;
}

@end



@interface LRUCache ()

@property (nonatomic, readonly) NSUInteger limit;
// 可变的字典 记录数据通过<key , value>，快速获取
@property (nonatomic, readonly) NSMutableDictionary* cache;
// 记录顺序 以符合 LRU
@property (nonatomic, readonly) NSMutableArray* list;

@end

@implementation LRUCache

- (instancetype)init:(NSUInteger)limit {
    if (self = [super init]) {
        _limit = limit;
        _cache = [NSMutableDictionary new];
        _list = [NSMutableArray new];
    }
    return self;
}

- (void)setObject:(id)obj forKey:(NSString*)key {
    _Element* old = [_cache objectForKey:key];
    if (old) {
        old.obj = obj;
        [_list removeObjectIdenticalTo:old];
        [_list insertObject:old atIndex:0];
        return;
    } else {
        _Element* newElement = [[_Element alloc] initObject:obj forKey:key];
        [_cache setObject:newElement forKey:key];
        [_list insertObject:newElement atIndex:0];
    }
    
    if (_list.count > _limit) {
        old = [_list lastObject];
        [_list removeLastObject];
        [_cache removeObjectForKey:old.key];
    }
}

- (id)objectForKey:(NSString*)key {
    _Element* obj = [_cache objectForKey:key];
    if (obj != nil) {
        [_list removeObjectIdenticalTo:obj];
        [_list insertObject:obj atIndex:0];
    }
    return obj.obj;
}

- (void)removeObjectForKey:(NSString*)key {
    _Element* obj = [_cache objectForKey:key];
    if (obj == nil) {
        return;
    }
    [_cache removeObjectForKey:key];
    [_list removeObjectIdenticalTo:obj];
}

- (void)removeAllObjects {
    [_cache removeAllObjects];
    [_list removeAllObjects];
}

@end
