//
//  TouchNum.m
//  AFNetworking
//
//  Created by hx on 2022/9/16.
//

#import "TouchNum.h"

@interface HXNumNode : NSObject

@property (nonatomic, strong) NSArray * arrA;

@property (nonatomic, strong) NSArray * arrB;

@property (nonatomic, strong) NSMutableArray<HXNumNode *> * childMutArr;


@end

@implementation HXNumNode

- (instancetype)initWithArrA:(NSArray *)arrA ArrB:(NSArray *)arrB {
    self = [super init];
    if (self) {
        self.arrA = arrA;
        self.arrB = arrB;
    }
    return self;
}

- (void)printNumNode {
    NSLog(@"%@ %@",self.arrA,self.arrB);
}

@end


@interface TouchNum ()

@end

@implementation TouchNum


- (instancetype)init
{
    self = [super init];
    if (self) {
        HXNumNode * t = [[HXNumNode alloc] initWithArrA:@[@(1),@(2)] ArrB:@[@(3),@(4)]];
        
        [t printNumNode];
    }
    return self;
}

@end
