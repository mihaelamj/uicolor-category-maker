//
//  MMJColorCategoryImagesWriter.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 09/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorCategoryImagesWriter.h"
#import "MMJFileWriter.h"

@interface MMJColorCategoryImagesWriter()
@property (strong, nonatomic) NSDictionary *imagesDictionary;
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSString *directory;
@end

@implementation MMJColorCategoryImagesWriter

#pragma mark - Private

- (id)initWithCategoryName:(NSString *)categoryName imagesDictionary:(NSDictionary *)imagesDictionary directory:(NSString *)directory
{
    if (!categoryName || !imagesDictionary || !directory)
        return nil;
    
    self = [super init];
    if (self) {
        _categoryName = categoryName;
        _imagesDictionary = imagesDictionary;
        _directory = directory;
    }
    return self;
}

- (NSString *)writeColorCategoryImages
{
    //get all color names from dictionary
    NSArray *colorImageNames = [self.imagesDictionary allKeys];
    
    __block NSString *filesPath = nil;
    
    //for each image in dictionary
    [colorImageNames enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        //image name
        NSString *colorImageName = (NSString *)object;
        //image
        UIImage *colorImage = [self.imagesDictionary objectForKey:colorImageName];
        //image file name
        NSString *imageName = [NSString stringWithFormat:@"%@.png", colorImageName];
        
        //write the images
        filesPath = [MMJFileWriter writeImage:colorImage fileName:imageName directoryName:self.directory];
    }];
    
    return filesPath;
}

#pragma mark - Public

+ (NSString *)makeColorCategoryImagesCategoryName:(NSString *)categoryName imagesDictionary:(NSDictionary *)colorsDictionary directory:(NSString *)directory
{
    MMJColorCategoryImagesWriter *writer = [[MMJColorCategoryImagesWriter alloc] initWithCategoryName:categoryName imagesDictionary:colorsDictionary directory:directory];
    if (!writer) return nil;
    
    return [writer writeColorCategoryImages];
}

@end
