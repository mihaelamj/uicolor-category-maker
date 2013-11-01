//
//  MMJFileWriter.m
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 30/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJFileWriter.h"

@implementation MMJFileWriter

+ (void)writeFileName:(NSString *)fileName directoryName:(NSString *)directoryName fileBody:(NSString *)fileBody
{
    // For error information
    NSError *error;
    
    // Create file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *documentsDirectory = [NSHomeDirectory()
                                    stringByAppendingPathComponent:directoryName];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSLog(@"Path: %@", filePath);
    // Write the file
    [fileBody writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    // Show contents of Documents directory
    NSLog(@"Documents directory: %@", [fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error]);
}
@end
