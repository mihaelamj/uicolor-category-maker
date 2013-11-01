//
//  MMJNamedColorParser.h
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 29/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJNamedColorParser : NSObject

- (id)initWithFileName:(NSString *)fileName fileType:(NSString *)fileType;

- (NSDictionary *)parseColorArrayIntoDictionary:(NSArray *)colorArray; //abstract

- (NSDictionary *)parse;

@end
