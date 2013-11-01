//
//  MMJColorCategoryWriter.h
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 01/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJColorCategoryWriter : NSObject
+ (NSString *)makeColorCategoryFilesCategoryName:(NSString *)categoryName colorsDictionary:(NSDictionary *)colorsDictionary directory:(NSString *)directory;
@end
