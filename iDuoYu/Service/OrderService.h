//
//  OrderService.h
//  iDuoYu
//
//  Created by ky01 on 15/4/19.
//  Copyright (c) 2015年 iduoyu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParam.h"
#import "ResultRespond.h"
#import "Engineers.h"
#import "DeviceParams.h"
#import "Orders.h"

@interface OrderService : NSObject

+ (Engineers *)getEngineerList:(RequestParam *)requestParam;

//+ (ResultRespond *)getDeviceParamIds:(RequestParam *)requestParam;
//
//+ (DeviceParams *)getDeviceParamList:(RequestParam *)requestParam;
//
//+ (ResultRespond *)submitOrder:(RequestParam *)requestParam;
//
//+ (Orders *)getOrderList:(RequestParam *)requestParam;

@end