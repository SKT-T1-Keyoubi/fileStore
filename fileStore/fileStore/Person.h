//
//  Person.h
//  fileStore
//
//  Created by LoveQiuYi on 16/1/22.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Person对象遵循了NScoding协议可以进行归档解档操作
 */
@interface Person : NSObject<NSCoding>
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) NSInteger age;
@end
