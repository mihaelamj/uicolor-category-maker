//
//  MMJColorCategoryImagesWriter.h
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJColorCategoryImagesWriter : NSObject

+ (NSString *)makeColorCategoryImagesCategoryName:(NSString *)categoryName imagesDictionary:(NSDictionary *)colorsDictionary directory:(NSString *)directory;

@end
