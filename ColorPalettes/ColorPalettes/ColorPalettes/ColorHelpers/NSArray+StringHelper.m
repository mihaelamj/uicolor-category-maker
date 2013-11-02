//
//  NSArray+StringHelper.m
//  CoreTextTest2
//
//  Created by Mihaela MJ on 10/10/13.
//  Copyright (c) 2013 Mihaela MJ. All rights reserved.
//

#import "NSArray+StringHelper.h"

@implementation NSArray (StringHelper)

- (BOOL)containsAString:(NSString *)string
{
    return self && (!([self indexOfObject:string] == NSNotFound));
}

@end
