//
//  MMJFileWriter.h
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 30/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMJFileWriter : NSObject
+ (void)writeFileName:(NSString *)fileName directoryName:(NSString *)directoryName fileBody:(NSString *)fileBody;
@end
