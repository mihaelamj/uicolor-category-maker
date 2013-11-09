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

//making images from colors and README.md
#import "MMJColorImagesWithReadme.h"

@implementation MMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //[self generateCopic];
  //  [self generateHtml];
//    [self generateCrayola];
    [self generatePantone];
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
    
    //make images and readme file
    CGSize imageSize = CGSizeMake(150, 50);
    NSString *gitHubPath = @"https://raw.github.com//mihaelamj/uicolor-copic/master/images/";
    
    NSString *readmePath = [MMJColorImagesWithReadme makeColorImagesForCategory:categoryName directory:directory colorsSource:colorCodesSource imageSize:imageSize gitHubPath:gitHubPath colorsDictionary:copicColors];
    NSLog(@"readme file written to /n%@", readmePath);
}

- (void)generateHtml
{
    NSString *categoryName = @"HTML";
    NSString *directory = @"Documents";
    NSString *colorCodesSource = @"http://www.w3schools.com/html/html_colornames.asp";
    
    NSDictionary *htmlColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"html_named" fileType:@"txt"];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:categoryName
                           colorsDictionary:htmlColors
                           directory:directory
                           colorCodesSource:colorCodesSource];
    NSLog(@"files written to /n%@", filesPath);
    
    //make images and readme file
    CGSize imageSize = CGSizeMake(150, 50);
    NSString *gitHubPath = @"https://raw.github.com//mihaelamj/uicolor-html/master/images/";
    NSString *readmePath = [MMJColorImagesWithReadme makeColorImagesForCategory:categoryName directory:directory colorsSource:colorCodesSource imageSize:imageSize gitHubPath:gitHubPath colorsDictionary:htmlColors shortFormat:YES];
    NSLog(@"readme file written to /n%@", readmePath);
}

- (void)generateCrayola
{
    NSString *categoryName = @"Crayola";
    NSString *directory = @"Documents";
    NSString *colorCodesSource = @"http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors";
    
    NSDictionary *crayolaColors = [MMJCrayolaColorParser crayolaColorsDictionary];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:categoryName
                           colorsDictionary:crayolaColors
                           directory:directory
                           colorCodesSource:colorCodesSource];
    NSLog(@"files written to /n%@", filesPath);
    
    //make images and readme file
    CGSize imageSize = CGSizeMake(150, 50);
    NSString *gitHubPath = @"https://raw.github.com//mihaelamj/uicolor-crayola/master/images/";
    NSString *readmePath = [MMJColorImagesWithReadme makeColorImagesForCategory:categoryName directory:directory colorsSource:colorCodesSource imageSize:imageSize gitHubPath:gitHubPath colorsDictionary:crayolaColors shortFormat:YES];
    NSLog(@"readme file written to /n%@", readmePath);
}

- (void)generatePantone
{
    NSString *categoryName = @"Pantone";
    NSString *directory = @"Documents";
    NSString *colorCodesSource = @"http://www.umsiko.co.za/links/color.html";
    
    NSDictionary *pantoneColors = [MMJGenericColorParser
                                   genericColorsDictionaryWithFileName:categoryName
                                   fileType:@"txt"
                                   colorNameIndex:0
                                   colorHexCodeIndex:7];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:categoryName
                           colorsDictionary:pantoneColors directory:directory
                           colorCodesSource:colorCodesSource];
    NSLog(@"files written to /n%@", filesPath);
    
    //make images and readme file
    CGSize imageSize = CGSizeMake(150, 50);
    NSString *gitHubPath = @"https://raw.github.com//mihaelamj/uicolor-pantone/master/images/";
    NSString *readmePath = [MMJColorImagesWithReadme makeColorImagesForCategory:categoryName directory:directory colorsSource:colorCodesSource imageSize:imageSize gitHubPath:gitHubPath colorsDictionary:pantoneColors shortFormat:YES];
    NSLog(@"readme file written to /n%@", readmePath);
}

- (void)generateCrayon
{
    NSString *categoryName = @"Crayon";
    NSString *directory = @"Documents";
    NSString *colorCodesSource = @"http://www.colourlovers.com/web/blog/2008/04/22/all-120-crayon-names-color-codes-and-fun-facts (spaces between color names removed by hand)";
    
    NSDictionary *crayonColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"Crayons" fileType:@"txt"];
    
    NSString *filesPath = [MMJColorCategoryWriter
                           makeColorCategoryFilesCategoryName:categoryName
                           colorsDictionary:crayonColors
                           directory:directory
                           colorCodesSource:colorCodesSource];
    NSLog(@"files written to /n%@", filesPath);
    
    //make images and readme file
    CGSize imageSize = CGSizeMake(150, 50);
}

@end
