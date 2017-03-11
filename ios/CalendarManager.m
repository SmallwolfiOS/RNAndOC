//
//  CalendarManager.m
//  Helloworld
//
//  Created by Jason on 16/8/5.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CalendarManager.h"
#import "RCTConvert.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation CalendarManager


@synthesize bridge=_bridge;


//默认名称
RCT_EXPORT_MODULE()
//对外提供调用方法
RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location){
  NSLog(@"Pretending to create an event %@ at %@", name, location);
}
//对外提供调用方法,为了演示事件时间格式化 secondsSinceUnixEpoch
RCT_EXPORT_METHOD(addEventMore:(NSString *)name location:(NSString *)location data:(NSNumber*)secondsSinceUnixEpoch){
  NSDate *date = [RCTConvert NSDate:secondsSinceUnixEpoch];
}
//对外提供调用方法,为了演示事件时间格式化 ISO8601DateString
RCT_EXPORT_METHOD(addEventMoreTwo:(NSString *)name location:(NSString *)location date:(NSString *)ISO8601DateString)
{
  NSDate *date = [RCTConvert NSDate:ISO8601DateString];
}
//对外提供调用方法,为了演示事件时间格式化 自动类型转换
RCT_EXPORT_METHOD(addEventMoreDate:(NSString *)name location:(NSString *)location date:(NSDate *)date)
{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSLog(@"获取的事件信息:%@,地点:%@,时间:%@",name,location,[formatter stringFromDate:date]);
}

//对外提供调用方法,为了演示事件时间格式化 传入属性字段
RCT_EXPORT_METHOD(addEventMoreDetails:(NSString *)name details:(NSDictionary *) dictionary)
{
  NSString *location = [RCTConvert NSString:dictionary[@"location"]];
  NSDate *time = [RCTConvert NSDate:dictionary[@"time"]];
  NSString *description=[RCTConvert NSString:dictionary[@"description"]];
  NSLog(@"获取的事件信息:%@,地点:%@,时间:%@,备注信息:%@",name,location,time,description);
  
}
//进行触发发送通知事件
RCT_EXPORT_METHOD(sendNotification:(NSString *)name){//这里受收到了react-native的通知
  dispatch_async(dispatch_get_main_queue(), ^{//亲测不再主线程中执行的话，会延迟执行
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"收到了RN发送过来的通知" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
    [alert show];
  });

  [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder"
                                               body:@{@"name": @"张三"}];

//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calendarEventReminderReceived:) name:nil object:nil];
}
//进行设置发送事件通知给JavaScript端
- (void)calendarEventReminderReceived:(NSNotification *)notification
{
  NSLog(@"xxxxx");
  [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder"
                                               body:@{@"name": @"张三"}];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
