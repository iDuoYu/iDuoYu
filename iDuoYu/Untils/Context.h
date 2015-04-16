//
//  Context.h
//  UFC singletom 全局上下文对象，用于保存会话信息等
//
//  Created by Roy on 10-12-30.
//  Copyright 2010 UFIDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface Context : NSObject
{
    CGFloat screenWitch;
    CGFloat screenHeight;
}

@end