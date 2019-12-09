//
//  YYWeakProxy.h
//  Test
//
//  Created by zhang dekai on 2019/12/7.
//  Copyright © 2019 张德凯. All rights reserved.
//

/*
 
 NSProxy一点应用： https://www.cnblogs.com/chaochaobuhuifei55/p/9100006.html
 
 场景：使用 NSTimer or CADisplayLink 定时器时，target是自己的情况下被强引用，即使使用weakself也无效

 
 NSProxy是和NSObject同级的一个类，可以说它是一个虚拟类，它只是实现了<NSObject>的协议；
 OC是单继承的语言，但是基于运行时的机制，却有一种方法让它来实现一下"伪多继承"，就是利用NSProxy这个类；
 OC中的NSProxy类，填补了"多继承"这个空白；
 通过继承NSProxy，并重写这两个方法以实现消息转发到另一个实例。

 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYWeakProxy : NSProxy

/**
 * @return target The target which will be forwarded all messages sent to the weak proxy.
 */
@property (nonatomic, weak, readonly) id target;


/**
 * An object which forwards messages to a target which it weakly references
 *
 * @discussion This class is useful for breaking retain cycles. You can pass this in place
 * of the target to something which creates a strong reference. All messages sent to the
 * proxy will be passed onto the target.
 *
 * @return an instance of YYWeakProxy
 */
+ (instancetype)weakProxyWithTarget:(id)target NS_RETURNS_RETAINED;






@end

NS_ASSUME_NONNULL_END
