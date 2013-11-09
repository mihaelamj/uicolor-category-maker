//
//  MMJColorPalettes.m
//  ColorPalettes
//
//  Created by Mihaela Mihaljević Jakić on 02/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorPalettes.h"

/**
 *  Import all color categories to use in the project
 */


#import "UIColor+Copic.h"
#import "UIColor+Crayola.h"
#import "UIColor+Pantone.h"
#import "UIColor+Html.h"
#import "UIColor+Crayon.h"

#import "UIColor+StandardColors.h"

@interface MMJColorPalettes()

@end

@implementation MMJColorPalettes

#pragma mark - Properties
/**
 *  Add color category name (palette) to the array
 *
 *  @return array of palette/category names
 */
- (NSArray *)palletes
{
    if (!_palletes) {
        _palletes = @[@"copic", @"crayola", @"pantone", @"html", @"crayon"];
    }
    return _palletes;
}

/**
 *  Color family repository
 *
 *  @return colors for a given category
 */

#pragma mark - Public methods

- (NSArray *)colorsForPalette:(NSString *)palette
{
    NSArray *colors = [UIColor colorNamesWithPrefix:[NSString stringWithFormat:@"%@_", palette]];
    return colors;
}


@end
