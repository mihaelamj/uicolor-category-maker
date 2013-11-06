//
//  MMJColorCategoryImagesMaker.h
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 06/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJColorCategoryImagesMaker : NSObject

+ (NSDictionary *)imagesForColorCategoryNamed:(NSString *)colorCategoryName withColorDictionary:(NSDictionary *)colorDictionary size:(CGSize)size;

@end
