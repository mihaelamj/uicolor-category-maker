//
//  NSString+MethodList.h
//  ClassMethodList
//
//  Created by Mihaela Mihaljević Jakić on 10/19/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MethodList)

+ (NSMutableArray *)getClassOrInstanceMethodsFromClassName:(NSString *)className getClassMethods:(BOOL)getClassMethods;

@end
