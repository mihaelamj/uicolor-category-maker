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

@implementation MMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self testCopic];
    [self testHTML];
    [self testHTML1];
    
    return YES;
}

- (void)testCopic
{
    //test Copic
    NSDictionary *copicColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"Copic_Color_HEX_CODE" fileType:@"txt"];
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"CopicColors" colorsDictionary:copicColors directory:@"Documents"];
    NSLog(@"files written to /n%@", filesPath);
}

- (void)testHTML
{
    NSDictionary *htmlColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"HTML_Colors1" fileType:@"txt"];
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"HTML" colorsDictionary:htmlColors directory:@"Documents"];
    NSLog(@"files written to /n%@", filesPath);
}

- (void)testHTML1
{
    NSDictionary *htmlColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"HTML1" fileType:@"txt"];
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"HTML1" colorsDictionary:htmlColors directory:@"Documents"];
    NSLog(@"files written to /n%@", filesPath);
}

@end
