//
//  MMJGenericColorParser.h
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 01/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJNamedColorParser.h"

@interface MMJGenericColorParser : MMJNamedColorParser
+ (NSDictionary *)genericColorsDictionaryWithFileName:(NSString *)fileName fileType:(NSString *)fileType;

+ (NSDictionary *)genericColorsDictionaryWithFileName:(NSString *)fileName fileType:(NSString *)fileType colorNameIndex:(int)colorNameIndex colorHexCodeIndex:(int)colorHexCodeIndex;

- (NSString *)cleanLineString:(NSString *)lineString; //virual
@end
