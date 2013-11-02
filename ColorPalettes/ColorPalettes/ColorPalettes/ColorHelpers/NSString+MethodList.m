//
//  NSString+MethodList.m
//  ClassMethodList
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "NSString+MethodList.h"
#import <objc/runtime.h>

@implementation NSString (MethodList)

+ (NSMutableArray *)getClassOrInstanceMethodsFromClassName:(NSString *)className getClassMethods:(BOOL)getClassMethods
{
    const char *ccName = [className UTF8String];
    int unsigned numMethods;
    id classDefinition = nil;
    
    NSMutableArray *result = nil;
    
    // inspect class or metaclass
    if (getClassMethods)
        classDefinition = objc_getMetaClass(ccName);
    else
        classDefinition = objc_getClass(ccName);
    
    Method *methods = class_copyMethodList(classDefinition, &numMethods);
    
    //allocate result array
    result = [[NSMutableArray alloc] initWithCapacity:numMethods];
    
    for (int i = 0; i < numMethods; i++) {
        NSString *methodName = NSStringFromSelector(method_getName(methods[i]));
        [result addObject:methodName];
    }
    
    return result;
}

@end
