//
//  MMJColorCategoryWriter.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 01/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorCategoryWriter.h"

#import "MMJColorCategoryMaker.h"
#import "MMJFileWriter.h"
#import "UIColor+HexString.h"

@interface MMJColorCategoryWriter()
@property (strong, nonatomic) NSDictionary *colorsDictionary;
@property (strong, nonatomic) NSString *categoryName;
@property (strong, nonatomic) NSString *directory;
@property (strong, nonatomic) NSString *colorCodesSource;
@end

@implementation MMJColorCategoryWriter

#pragma mark - Private

- (id)initWithCategoryName:(NSString *)categoryName colorsDictionary:(NSDictionary *)colorsDictionary directory:(NSString *)directory colorCodesSource:(NSString *)colorCodesSource
{
    if (!categoryName || !colorsDictionary || !directory)
        return nil;
    
    self = [super init];
    if (self) {
        _categoryName = categoryName;
        _colorsDictionary = colorsDictionary;
        _directory = directory;
        _colorCodesSource = colorCodesSource;
    }
    return self;
}

- (NSString *)writeColorCategoryFiles
{
    __block NSString *_interfaceFileName = nil;
    __block NSString *_implementationFileName = nil;
    __block NSString *_interfaceBody = nil;
    __block NSString *_implementationBody = nil;
    
    [MMJColorCategoryMaker getFileBodiesForColorCategoryNamed:self.categoryName withColorDictionary:self.colorsDictionary colorCodesSource:self.colorCodesSource withReturnBlock:^(NSString *interfaceFileName, NSString *implementationFileName, NSString *interfaceBody, NSString *implementationBody, NSError *error){
        
        _interfaceFileName = interfaceFileName,
        _implementationFileName = implementationFileName;
        _interfaceBody = interfaceBody;
        _implementationBody = implementationBody;
    }];
    NSLog(@"interfaceFileName /n%@", _interfaceFileName);
    NSLog(@"implementationFileName /n%@", _implementationFileName);
    
    //write the files
    NSString *filesPath = [MMJFileWriter writeFileName:_interfaceFileName directoryName:self.directory fileBody:_interfaceBody];
    [MMJFileWriter writeFileName:_implementationFileName directoryName:self.directory fileBody:_implementationBody];
    
    return filesPath;
}

#pragma mark - Public

+ (NSString *)makeColorCategoryFilesCategoryName:(NSString *)categoryName colorsDictionary:(NSDictionary *)colorsDictionary directory:(NSString *)directory colorCodesSource:(NSString *)colorCodesSource
{
    MMJColorCategoryWriter *writer = [[MMJColorCategoryWriter alloc] initWithCategoryName:categoryName colorsDictionary:colorsDictionary directory:directory colorCodesSource:colorCodesSource];
    if (!writer) return nil;
    
    return [writer writeColorCategoryFiles];
}

@end
