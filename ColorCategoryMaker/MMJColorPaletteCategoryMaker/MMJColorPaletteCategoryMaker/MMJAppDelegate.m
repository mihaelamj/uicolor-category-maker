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

@implementation MMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self generateCopic];
    [self generateHtml];
    [self generateCrayola];
    [self generatePantone];
    
    return YES;
}

- (void)generateCopic
{
    NSDictionary *copicColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"Copic_Color_HEX_CODE" fileType:@"txt"];
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"Copic" colorsDictionary:copicColors directory:@"Documents"];
    NSLog(@"files written to /n%@", filesPath);
}

- (void)generateHtml
{
    NSDictionary *htmlColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"html_named" fileType:@"txt"];
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"HTML" colorsDictionary:htmlColors directory:@"Documents"];
    NSLog(@"files written to /n%@", filesPath);
}

- (void)generateCrayola
{
    NSDictionary *crayolaColors = [MMJCrayolaColorParser crayolaColorsDictionary];
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"Crayola" colorsDictionary:crayolaColors directory:@"Documents"];
    NSLog(@"files written to /n%@", filesPath);
}

- (void)generatePantone
{
    NSDictionary *pantoneColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"Pantone" fileType:@"txt" colorNameIndex:0 colorHexCodeIndex:7];
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"Pantone" colorsDictionary:pantoneColors directory:@"Documents" ];
    NSLog(@"files written to /n%@", filesPath);
}

@end
