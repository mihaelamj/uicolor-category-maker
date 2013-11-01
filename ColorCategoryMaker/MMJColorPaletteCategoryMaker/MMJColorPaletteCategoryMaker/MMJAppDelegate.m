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

//specific parser
#import "MMJCopicColorParser.h"

@implementation MMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self testWriter];
    return YES;
}

- (void)testWriter
{
    NSDictionary *copicColors = [MMJCopicColorParser copicColorsDictionary];
    
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"CopicColors" colorsDictionary:copicColors directory:@"Documents"];
    
    NSLog(@"files written to /n%@", filesPath);
}

@end
