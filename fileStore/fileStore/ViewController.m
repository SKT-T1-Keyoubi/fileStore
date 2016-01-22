//
//  ViewController.m
//  fileStore
//
//  Created by LoveQiuYi on 16/1/22.
//  Copyright © 2016年 LoveQiuYi. All rights reserved.
//  文件存储的几种方式总结

#import "ViewController.h"
#import "Person.h"
/**
 *  宏定义文件名以及文件存储的路径
 *
 *  @param NSDocumentDirectory 文件的主目录
 *  @param NSUserDomainMask    用户目录
 *  @param YES
 *  @return 应用程序沙盒路径
 *  注意和直接获取NSHomeDirectory()->return NSString的区别：后面这个值获取到沙盒路径的根目录，上面的获取到document目录下
 */
#define dataName @"data.plist"
#define filePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:dataName]
#define archiverPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"data.archiver"]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //plist文件的存储方式
    //[self plistStore];
    //[self userDefaultStore];
    [self archiverData];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   //读取偏好设置的数据
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //调用objectForKey来获取到数据
    NSString * name = [defaults objectForKey:@"name"];
    BOOL isMale = [defaults boolForKey:@"isMale"];
    NSLog(@"name is %@ and sex is %d",name,isMale);
    //GCD保证整个程序运行期间里面的代码只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(deleteDefaults) userInfo:nil repeats:YES];
        NSLog(@"sdsdsdsd");
    });
    /**
     *  解档
     *
     *  @return Person对象，读取数据
     */
    Person * person = [NSKeyedUnarchiver unarchiveObjectWithFile:archiverPath];
    NSLog(@"%@,%ld",person.name,(long)person.age);
    
}
#pragma mark - plist文件的存储
-(void) plistStore{
    //定义一个数据
    // NSArray * data = @[@"zhang",@"xin",@"strong"];
    NSDictionary * data = @{@"name":@"zhangxin",@"age":@23};
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * path = [doc stringByAppendingPathComponent:@"data.plist"];
    //数据写到文件里面去
    [data writeToFile:path atomically:YES];
    //注意存储的文件的格式要和输出的格式一致
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@",dic);
}
#pragma mark - 用户偏好设置
-(void) userDefaultStore{
    //创建偏好设置
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //设置数据
    [defaults setObject:@"zhangxin" forKey:@"name"];
    [defaults setBool:YES forKey:@"isMale"];
    /**
     *  立刻写入磁盘存起来，因为用户偏好设置存数据是根据时间戳定时的把缓存数据写到磁盘，如果要立即写进去，要用synchonize
     */
    [defaults synchronize];
    
}
#pragma mark - 删除数据
-(void) deleteDefaults{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"isMale"];
    [defaults synchronize];
    //NSLog(@"name is %@ and sex is %d",name,isMale);

}
#pragma mark - 归档
-(void) archiverData{
    Person * person = [[Person alloc]init];
    person.name = @"zhangxin";
    person.age = 20;
    [NSKeyedArchiver archiveRootObject:person toFile:archiverPath];
}
@end
