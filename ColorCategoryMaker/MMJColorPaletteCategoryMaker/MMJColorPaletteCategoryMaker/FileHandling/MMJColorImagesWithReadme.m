//
//  MMJColorImagesWithReadme.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorImagesWithReadme.h"

//making images from colors
#import "MMJColorCategoryImagesMaker.h"

//writing images to the disk
#import "MMJColorCategoryImagesWriter.h"

//writing README.md to the deisk
#import "MMJColorCategoryReadmeWriter.h"

@implementation MMJColorImagesWithReadme

+ (NSString *)makeColorImagesForCategory:(NSString *)category directory:(NSString *)directory colorsSource:(NSString *)colorsSource imageSize:(CGSize)imageSize gitHubPath:(NSString *)gitHubPath colorsDictionary:(NSDictionary *)colorsDictionary shortFormat:(BOOL)shortFormat
{
    //make dictionary with colorname : UIImage pairs
    NSDictionary *colorImages = [MMJColorCategoryImagesMaker imagesForColorCategoryNamed:category withColorDictionary:colorsDictionary size:imageSize];
    NSString *imagesPath = [MMJColorCategoryImagesWriter makeColorCategoryImagesCategoryName:category imagesDictionary:colorImages directory:directory];
    NSLog(@"images written to /n%@", imagesPath);
    
    NSString *readmePath = [MMJColorCategoryReadmeWriter makeColorCategoryReadmeFile:@"README.md" categoryName:category imagesDictionary:colorsDictionary directory:directory colorCodesSource:colorsSource gitHubPath:gitHubPath imageSize:imageSize shortFormat:shortFormat];
    return readmePath;
}

+ (NSString *)makeColorImagesForCategory:(NSString *)category directory:(NSString *)directory colorsSource:(NSString *)colorsSource imageSize:(CGSize)imageSize gitHubPath:(NSString *)gitHubPath colorsDictionary:(NSDictionary *)colorsDictionary
{
    return [MMJColorImagesWithReadme makeColorImagesForCategory:category directory:directory colorsSource:colorsSource imageSize:imageSize gitHubPath:gitHubPath colorsDictionary:colorsDictionary shortFormat:NO];
}

@end
