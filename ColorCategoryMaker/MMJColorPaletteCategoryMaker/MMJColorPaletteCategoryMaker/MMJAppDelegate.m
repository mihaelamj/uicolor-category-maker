//
//  MMJAppDelegate.m
//  MMJColorPaletteCategoryMaker
//
//  Created by Mihaela Mihaljević Jakić on 01/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJAppDelegate.h"

//files writer
#import "MMJColorCategoryWriter.h"

//generic parser
#import "MMJGenericColorParser.h"

//specific parsers
#import "MMJCrayolaColorParser.h"

//making images from colors
#import "MMJColorCategoryImagesMaker.h"

//writing images to the disk
#import "MMJColorCategoryImagesWriter.h"

//writing README.md to the deisk
#import "MMJColorCategoryReadmeWriter.h"

@implementation MMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self generateCopic];
//    [self generateHtml];
//    [self generateCrayola];
//    [self generatePantone];
//    [self generateCrayon]; 
    
    return YES;
}


- (void)generateCopic
{
// 1. make color category files
    NSString *categoryName = @"Copic";
    NSString *directory = @"Documents";
    NSString *colorCodesSource =@"http://blog.paigeedraw.com/2012/07/copic-marker-color-rgb-hex-conversion.html";
    
    NSDictionary *copicColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"Copic_Color_HEX_CODE" fileType:@"txt"];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:categoryName
                           colorsDictionary:copicColors
                           directory:directory
                           colorCodesSource:colorCodesSource];
    
    NSLog(@"files written to /n%@", filesPath);
    
// 2. make images in colors
    //make images dictionary
    CGSize imageSize = CGSizeMake(150, 50);
    //make dictionary with colorname : UIImage pairs
    NSDictionary *colorImages = [MMJColorCategoryImagesMaker imagesForColorCategoryNamed:categoryName withColorDictionary:copicColors size:imageSize];
    
    //NSString *imagesPath = [MMJColorCategoryImagesWriter makeColorCategoryImagesCategoryName:categoryName imagesDictionary:colorImages directory:directory];
    //NSLog(@"images written to /n%@", imagesPath);
    
// 3. make redame file for GitHub https://github.com/mihaelamj/uicolor-copic/master/images"
    NSString *gitHubPath = @"https://raw.github.com//mihaelamj/uicolor-copic/master/images/";
    
    NSString *readmePath = [MMJColorCategoryReadmeWriter makeColorCategoryReadmeFile:@"README.md" categoryName:categoryName imagesDictionary:colorImages directory:directory colorCodesSource:colorCodesSource gitHubPath:gitHubPath imageSize:imageSize];
    
     NSLog(@"readme file written to /n%@", readmePath);
}

- (void)generateHtml
{
    NSDictionary *htmlColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"html_named" fileType:@"txt"];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:@"HTML"
                           colorsDictionary:htmlColors
                           directory:@"Documents"
                           colorCodesSource:@"http://www.w3schools.com/html/html_colornames.asp"];
    
    NSLog(@"files written to /n%@", filesPath);
}

- (void)generateCrayola
{
    NSDictionary *crayolaColors = [MMJCrayolaColorParser crayolaColorsDictionary];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:@"Crayola"
                           colorsDictionary:crayolaColors
                           directory:@"Documents"
                           colorCodesSource:@"http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors"];
    
    NSLog(@"files written to /n%@", filesPath);
}

- (void)generatePantone
{
    NSDictionary *pantoneColors = [MMJGenericColorParser
                                   genericColorsDictionaryWithFileName:@"Pantone"
                                   fileType:@"txt"
                                   colorNameIndex:0
                                   colorHexCodeIndex:7];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:@"Pantone"
                           colorsDictionary:pantoneColors directory:@"Documents"
                           colorCodesSource:@"http://www.umsiko.co.za/links/color.html"];
    
    NSLog(@"files written to /n%@", filesPath);
}

- (void)generateCrayon
{
    NSDictionary *crayonColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"Crayons" fileType:@"txt"];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:@"Crayon"
                           colorsDictionary:crayonColors
                           directory:@"Documents"
                           colorCodesSource:@"http://www.colourlovers.com/web/blog/2008/04/22/all-120-crayon-names-color-codes-and-fun-facts (spaces between color names removed by hand)"];
    
    NSLog(@"files written to /n%@", filesPath);
}

@end
