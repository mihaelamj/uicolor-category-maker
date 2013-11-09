//
//  MMJColorCategoryMaker.h
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 30/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJColorCategoryMaker : NSObject

+ (void)getFileBodiesForColorCategoryNamed:(NSString *)colorCategoryName withColorDictionary:(NSDictionary *)colorDictionary colorCodesSource:(NSString *)colorCodesSource withReturnBlock:(void (^)(NSString *interfaceFileName, NSString *implementationFileName, NSString *interfaceBody, NSString *implementationBody, NSError *error))block;

@end
