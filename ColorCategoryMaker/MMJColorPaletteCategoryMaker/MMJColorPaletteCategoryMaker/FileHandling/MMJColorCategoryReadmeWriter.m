//
//  MMJColorCategoryReadmeWriter.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorCategoryReadmeWriter.h"

#import "MMJColorCategoryReadmeMaker.h"
#import "MMJFileWriter.h"

@interface MMJColorCategoryReadmeWriter()
@property (strong, nonatomic) NSDictionary *imagesDictionary;
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSString *directory;
@property (strong, nonatomic) NSString *readmeFileName;
@property (strong, nonatomic) NSString *colorsSource;
@property (strong, nonatomic) NSString *gitHubPath;
@property (nonatomic) CGSize imageSize;
@property (nonatomic) BOOL shortFormat;
@end

@implementation MMJColorCategoryReadmeWriter

#pragma mark - Private

- (id)initWithCategoryName:(NSString *)categoryName imagesDictionary:(NSDictionary *)imagesDictionary directory:(NSString *)directory readmeFileName:(NSString *)readmeFileName colorsSource:(NSString *)colorsSource gitHubPath:(NSString *)gitHubPath imageSize:(CGSize)imageSize shortFormat:(BOOL)shortFormat
{
    if (!categoryName || !imagesDictionary || !directory)
        return nil;
    
    self = [super init];
    if (self) {
        _categoryName = categoryName;
        _imagesDictionary = imagesDictionary;
        _directory = directory;
        _readmeFileName = readmeFileName;
        _colorsSource = colorsSource;
        _gitHubPath = gitHubPath;
        _imageSize = imageSize;
        _shortFormat = shortFormat;
    }
    return self;
}

- (NSString *)writeReadmeFile
{
    //get the README.md body
    NSString *readmeContents = [MMJColorCategoryReadmeMaker readmeContentsForColorCategoryName:self.categoryName colorCodesSource:self.colorsSource colorsDictionary:self.imagesDictionary imageSize:self.imageSize gitHubPath:self.gitHubPath imagesDirectory:self.directory shortFormat:self.shortFormat];
    
    //write the file
    NSString *filesPath = [MMJFileWriter writeFileName:self.readmeFileName directoryName:self.directory fileBody:readmeContents];
    return filesPath;
}

#pragma mark - Public

+ (NSString *)makeColorCategoryReadmeFile:(NSString *)fileName categoryName:(NSString *)categoryName imagesDictionary:(NSDictionary *)imagesDictionary directory:(NSString *)directory colorCodesSource:(NSString *)colorCodesSource gitHubPath:(NSString *)gitHubPath imageSize:(CGSize)imageSize shortFormat:(BOOL)shortFormat
{
    MMJColorCategoryReadmeWriter *writer = [[MMJColorCategoryReadmeWriter alloc] initWithCategoryName:categoryName imagesDictionary:imagesDictionary directory:directory readmeFileName:fileName colorsSource:colorCodesSource gitHubPath:gitHubPath imageSize:imageSize shortFormat:shortFormat];
    if (!writer) return nil;
    
    return [writer writeReadmeFile];
}

+ (NSString *)makeColorCategoryReadmeFile:(NSString *)fileName categoryName:(NSString *)categoryName imagesDictionary:(NSDictionary *)imagesDictionary directory:(NSString *)directory colorCodesSource:(NSString *)colorCodesSource gitHubPath:(NSString *)gitHubPath imageSize:(CGSize)imageSize
{
    MMJColorCategoryReadmeWriter *writer = [[MMJColorCategoryReadmeWriter alloc] initWithCategoryName:categoryName imagesDictionary:imagesDictionary directory:directory readmeFileName:fileName colorsSource:colorCodesSource gitHubPath:gitHubPath imageSize:imageSize shortFormat:NO];
    if (!writer) return nil;
    
    return [writer writeReadmeFile];
}

@end
