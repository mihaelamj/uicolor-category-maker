//
//  MMJColorCategoryReadmeMaker.h
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJColorCategoryReadmeMaker : NSObject

+ (NSString *)readmeContentsForColorCategoryName:(NSString *)colorCategoryName colorCodesSource:(NSString *)colorCodesSource imagesDictionary:(NSDictionary *)imagesDictionary imageSize:(CGSize)imageSize gitHubPath:(NSString *)gitHubPath imagesDirectory:(NSString *)imagesDirectory;

@end
