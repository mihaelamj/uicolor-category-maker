//
//  MMJFileWriter.h
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 30/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJFileWriter : NSObject
+ (NSString *)writeFileName:(NSString *)fileName directoryName:(NSString *)directoryName fileBody:(NSString *)fileBody;

+ (NSString *)writeImage:(UIImage *)image fileName:(NSString *)fileName directoryName:(NSString *)directoryName;
@end
