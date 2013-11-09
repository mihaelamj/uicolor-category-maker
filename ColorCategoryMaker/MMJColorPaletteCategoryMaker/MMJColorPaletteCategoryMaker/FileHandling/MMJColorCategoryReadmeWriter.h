//
//  MMJColorCategoryReadmeWriter.h
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJColorCategoryReadmeWriter : NSObject

+ (NSString *)makeColorCategoryReadmeFile:(NSString *)fileName categoryName:(NSString *)categoryName imagesDictionary:(NSDictionary *)imagesDictionary directory:(NSString *)directory colorCodesSource:(NSString *)colorCodesSource gitHubPath:(NSString *)gitHubPath imageSize:(CGSize)imageSize;

+ (NSString *)makeColorCategoryReadmeFile:(NSString *)fileName categoryName:(NSString *)categoryName imagesDictionary:(NSDictionary *)imagesDictionary directory:(NSString *)directory colorCodesSource:(NSString *)colorCodesSource gitHubPath:(NSString *)gitHubPath imageSize:(CGSize)imageSize shortFormat:(BOOL)shortFormat;

@end
