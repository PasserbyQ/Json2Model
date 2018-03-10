//
//  NSObject+QYModel.m
//  Json2Model
//
//  Created by PasserbyQ on 2018/3/10.
//  Copyright © 2018年 PasserbyQ. All rights reserved.
//

#import "NSObject+QYModel.h"
#import <objc/runtime.h>
@implementation NSObject (QYModel)

+(instancetype)json2Model:(NSDictionary *)dict
{
    //用来存放所有属性
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    
    //获取当前类及所有父类属性
    [self allProperties:keys aClass:[self class]];
    
    //创建当前模型对象
    id model = [[[self class] alloc] init];
    
    //遍历属性并赋值
    for (NSString *key in keys) {
        if ([dict valueForKey:key]) {
            [model setValue:[dict valueForKey:key] forKey:key];
        }
    }
    return model;
}

+(void)allProperties:(NSMutableArray *)keys aClass:(Class)aClass
{
    u_int count = 0;
    
    //到达系统类停止获取（可能有问题）
    if ([NSStringFromClass(aClass) isEqualToString:@"NSObject"]) {
        return;
    }
    
    //获取类的所有属性列表
    objc_property_t *properties = class_copyPropertyList(aClass, &count);
    for (int i=0; i<count; i++) {
        objc_property_t property = properties[i];
        
        //获取类属性名称
        const char *propertyCString = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:propertyCString encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    
    //循环获取父类的属性列表
    Class superClass = class_getSuperclass(aClass);
    [self allProperties:keys aClass:superClass];
}

@end
