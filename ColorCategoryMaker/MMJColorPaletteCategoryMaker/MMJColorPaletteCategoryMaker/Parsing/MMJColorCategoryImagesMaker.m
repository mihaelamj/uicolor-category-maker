//
//  MMJColorCategoryImagesMaker.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 06/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorCategoryImagesMaker.h"
#import "UIImage+Colored.h"

@implementation MMJColorCategoryImagesMaker

#pragma  mark - Private

+ (UIColor *)colorFromColorComponents:(NSDictionary *)colorComponents;
{
    int redPart = [[colorComponents objectForKey:@"red"] intValue];
    int greenPart = [[colorComponents objectForKey:@"green"] intValue];
    int bluePart = [[colorComponents objectForKey:@"blue"] intValue];
    int alphaPart = [[colorComponents objectForKey:@"alpha"] intValue];
    
    UIColor *color = [UIColor colorWithRed:redPart/255.0 green:greenPart/255.0 blue:bluePart/255.0 alpha:alphaPart/255.0];
    return color;
}

#pragma mark - Public

+ (NSDictionary *)imagesForColorCategoryNamed:(NSString *)colorCategoryName withColorDictionary:(NSDictionary *)colorDictionary size:(CGSize)size
{
    //get all color names from dictionary
    NSArray *colorNames = [colorDictionary allKeys];
    __block NSMutableDictionary *colorImages = [[NSMutableDictionary alloc] init];
    
    //for each color in dictionary
    [colorNames enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        
        //get color name
        NSString *colorName = (NSString *)object;
        //get color components
        NSDictionary *colorComponents = [colorDictionary objectForKey:colorName];
        
        //make color
        UIColor *color = [MMJColorCategoryImagesMaker colorFromColorComponents:colorComponents];
        
        //make image
        UIImage *image = [UIImage imageWithColor:color width:size.width height:size.height];
        
        //add image with color name to dictionary
        [colorImages setObject:image forKey:colorName];
    }];
    
    return [NSDictionary dictionaryWithDictionary:colorImages];
}

@end
