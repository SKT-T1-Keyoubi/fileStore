//
//  Person.m
//  fileStore
//
//  Created by LoveQiuYi on 16/1/22.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//

#import "Person.h"

@implementation Person
/**
 *  归档
 */
-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}
/**
*  解档
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}
@end
