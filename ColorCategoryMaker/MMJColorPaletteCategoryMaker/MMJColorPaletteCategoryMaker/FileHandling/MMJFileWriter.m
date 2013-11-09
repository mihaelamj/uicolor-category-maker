//
//  MMJFileWriter.m
//  NiceColors
//
//  Created by Mihaela Mihaljević Jakić on 30/10/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJFileWriter.h"

@implementation MMJFileWriter

+ (NSString *)writeFileName:(NSString *)fileName directoryName:(NSString *)directoryName fileBody:(NSString *)fileBody
{
    NSError *error;
    // Create file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:directoryName];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
#warning  implement error handling
    // Write the file
    [fileBody writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@ directory: %@", directory, [fileManager contentsOfDirectoryAtPath:directory error:&error]);
    return directory;
}

+ (NSString *)writeImage:(UIImage *)image fileName:(NSString *)fileName directoryName:(NSString *)directoryName
{
    NSError *error;
    // Create file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:directoryName];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    
    //get image PNG data
    NSData *pngData = UIImagePNGRepresentation(image);
    
    // Write the image file
    [pngData writeToFile:filePath atomically:YES];
    
    NSLog(@"%@ directory: %@", directory, [fileManager contentsOfDirectoryAtPath:directory error:&error]);
    return directory;
}

@end
