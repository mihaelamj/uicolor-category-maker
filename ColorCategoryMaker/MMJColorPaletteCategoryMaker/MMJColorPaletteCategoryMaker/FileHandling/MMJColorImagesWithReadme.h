//
//  MMJColorImagesWithReadme.h
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJColorImagesWithReadme : NSObject

+ (NSString *)makeColorImagesForCategory:(NSString *)category directory:(NSString *)directory colorsSource:(NSString *)colorsSource imageSize:(CGSize)imageSize gitHubPath:(NSString *)gitHubPath colorsDictionary:(NSDictionary *)colorsDictionary;

@end
