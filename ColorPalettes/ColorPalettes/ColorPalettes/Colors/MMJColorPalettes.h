//
//  MMJColorPalettes.h
//  ColorPalettes
//
//  Created by Mihaela Mihaljević Jakić on 02/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJColorPalettes : NSObject

@property (strong, nonatomic) NSArray *palletes;

- (NSArray *)colorsForPalette:(NSString *)palette;

@end
