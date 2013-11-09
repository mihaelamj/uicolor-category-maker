//
//  MMJColorCategoryReadmeMaker.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorCategoryReadmeMaker.h"
#import "NSString+MMJUtils.h"

//readme
#define README_FILE_NAME @"README.md"
#define COLOR_CATEGORY_NAME @"%@"
#define COLORS_SOURCE @"\nColor codes source: %@\n"
#define CREDITS @"\nGenerated by https://github.com/mihaelamj/uicolor-category-maker\n Created by Mihaela Mihaljević Jakić\n"

//table
#define TABLE_START @"<table>\n"
#define TABLE_END @"</table>\n"

#define TABLE_ROW @"<tr>\n<td>%@</td>\n<td>%@</td>\n<td>%@</td>\n</tr>\n"
// 1. image source
// 2. color name
// 3. color code

#define IMAGE_SOURCE @"\"%@%@\""
//"https://raw.github.com/mihaelamj/uicolor-copic/master/images/copic_b41_Color.png"
// 1. path to github account            https://raw.github.com/mihaelamj
// 2. relative path to images directory uicolor-copic/master/images
// 2. image file name                   copic_b41_Color.png

//width="50" height="30" alt="copic_b41"
#define IMAGE_DATA @"width=\"%d\" height=\"%d\" alt=\"%@\""
// 1. image width                       50
// 2. image height                      30
// 3. color name                        copic_b41_Color

#define IMAGE_URL @"<img src=\%@ %@ />"
// 1. image source
// 2. image data

//<img src="https://raw.github.com/mihaelamj/uicolor-copic/master/images/copic_b41_Color.png" width="50" height="30" alt="copic_b41" />

#define COLOR_CODE @"[UIColor %@]"      //[UIColor copic_b41_Color]

@implementation MMJColorCategoryReadmeMaker

#pragma  mark - Private Methods

+ (NSString *)readmeTitleForColorCategory:(NSString *)colorCategory
{
    NSString *category = [NSString stringWithFormat:@"UIColor+%@", [colorCategory stringCapitilized]];
    return [NSString stringWithFormat:@"%@\n%@\n\n", category, @"======================"];
}

+ (NSString *)colorSource:(NSString *)source
{
    return [NSString stringWithFormat:COLORS_SOURCE, source];
}

+ (void)appendIntroToString:(NSMutableString *)string colorCategoryName:(NSString *)colorCategoryName colorCodesSource:(NSString *)colorCodesSource
{
    //append title
    [string appendString:[MMJColorCategoryReadmeMaker readmeTitleForColorCategory:colorCategoryName]];
    
    //append source of color codes
    [string appendString:[MMJColorCategoryReadmeMaker colorSource:colorCodesSource]];
    
    //append credits
    [string appendString:CREDITS];
}

+ (NSString *)imageSourceFromImageFileName:(NSString *)imageFileName gitHubPath:(NSString *)gitHubPath
{
    return [NSString stringWithFormat:IMAGE_SOURCE, gitHubPath, imageFileName];
}

+ (NSString *)imageDataFromImageSize:(CGSize)imageSize altName:(NSString *)altName
{
    return [NSString stringWithFormat:IMAGE_DATA, (int)imageSize.width, (int)imageSize.height, altName];
}

+ (NSString *)fullImageSourceFromImageFileName:(NSString *)imageFileName gitHubPath:(NSString *)gitHubPath imageSize:(CGSize)imageSize altName:(NSString *)altName
{
    NSString *imageSource = [MMJColorCategoryReadmeMaker imageSourceFromImageFileName:imageFileName gitHubPath:gitHubPath];
    NSString *imageData = [MMJColorCategoryReadmeMaker imageDataFromImageSize:imageSize altName:altName];
    
    return [NSString stringWithFormat:IMAGE_URL, imageSource, imageData];
}

+ (NSString *)tableRowForImageSource:(NSString *)imageSource colorName:(NSString *)colorName colorCode:(NSString *)colorCode
{
    return [NSString stringWithFormat:TABLE_ROW, imageSource, colorName, colorCode];
}

+ (NSString *)tableStringFromImagesDictionary:(NSDictionary *)imagesDictionary categoryName:(NSString *)categoryName imageSize:(CGSize)imageSize gitHubPath:(NSString *)gitHubPath imagesDirectory:(NSString *)imagesDirectory
{
   __block NSMutableString *tableString = [[NSMutableString alloc] init];
    
    //start table
    [tableString appendString:TABLE_START];
    
    //get all color names from dictionary
    NSArray *colorImageNames = [imagesDictionary allKeys];
    
    //for each color in dictionary
    [colorImageNames enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        //image name
        NSString *colorImageName = (NSString *)object;
        
        //full image name
//        NSString *imageName = [NSString stringWithFormat:@"%@.png", colorImageName];
        NSString *imageName = [NSString stringWithFormat:@"%@_%@_%@.png", [categoryName lowercaseString], @"Color", colorImageName];
        
        NSString *imageAlt = [NSString stringWithFormat:@"%@ color: %@", categoryName, colorImageName];
        
        NSString *imgSrc = [MMJColorCategoryReadmeMaker fullImageSourceFromImageFileName:imageName gitHubPath:gitHubPath imageSize:imageSize altName:imageAlt];
        
        NSString *colorMethodName = [NSString stringWithFormat:@"%@_%@_%@", [categoryName lowercaseString], @"Color", colorImageName];
        
        NSString *colorCode = [NSString stringWithFormat:COLOR_CODE, colorMethodName];
        
        //make table row
        NSString *tableRow = [MMJColorCategoryReadmeMaker tableRowForImageSource:imgSrc colorName:colorMethodName colorCode:colorCode];
        //add table row to result
        [tableString appendString:[NSString stringWithFormat:@"%@", tableRow]];
    }];
    
    //end table
    [tableString appendString:TABLE_END];
    return [NSString stringWithString:tableString];
}

#pragma mark - Public Methods

+ (NSString *)readmeContentsForColorCategoryName:(NSString *)colorCategoryName
                                colorCodesSource:(NSString *)colorCodesSource
                                imagesDictionary:(NSDictionary *)imagesDictionary
                                       imageSize:(CGSize)imageSize
                                      gitHubPath:(NSString *)gitHubPath
                                 imagesDirectory:(NSString *)imagesDirectory
{
    NSMutableString *readmeBodyString = [[NSMutableString alloc] init];
    
    //append intro to redme
    [MMJColorCategoryReadmeMaker appendIntroToString:readmeBodyString colorCategoryName:colorCategoryName colorCodesSource:colorCodesSource];
    
    //append table to string
    NSString *tableString = [MMJColorCategoryReadmeMaker tableStringFromImagesDictionary:imagesDictionary categoryName:colorCategoryName imageSize:imageSize gitHubPath:gitHubPath imagesDirectory:imagesDirectory];
    [readmeBodyString appendString:tableString];
    
    return [NSString stringWithString:readmeBodyString];
}

@end
