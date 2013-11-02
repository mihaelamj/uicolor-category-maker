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
#import "UIColor+HTML.h"
#import "UIColor+HTML1.h"

@interface MMJColorPalettes()
@property (strong, nonatomic) NSArray *palletes;
@end

@implementation MMJColorPalettes

#pragma mark - Properties

- (NSArray *)palletes
{
    if (!_palletes) {
        _palletes = @[@"Copic", @"Crayola", @"HTML", @"HTML1"];
    }
    return _palletes;
}

@end
