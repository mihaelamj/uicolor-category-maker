//
//  NSString+MMJUtils.h
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMJUtils)
- (NSString *)stringCapitilized;

+ (NSString *)stringPaddedWithString:(NSString *)string length:(int)length;
@end
