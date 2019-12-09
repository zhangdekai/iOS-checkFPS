//
//  YYWeakProxy.m
//  Test
//
//  Created by zhang dekai on 2019/12/7.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import "YYWeakProxy.h"

@implementation YYWeakProxy

- (instancetype)initWithTarget:(id)target {
    
    if (self) {
        _target = target;
    }
    return self;
}


+ (instancetype)weakProxyWithTarget:(id)target {
    
    return [[YYWeakProxy alloc]initWithTarget:target];
}


- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation  invokeWithTarget:self.target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    return [_target methodSignatureForSelector:sel];
}



@end
