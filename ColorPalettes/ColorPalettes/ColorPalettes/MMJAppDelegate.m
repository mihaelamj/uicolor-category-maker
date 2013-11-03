//
//  MMJAppDelegate.m
//  ColorPalettes
//
//  Created by Mihaela Mihaljević Jakić on 01/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJAppDelegate.h"
#import "MMJColorPaletteChooserViewController.h"

//test
#import "UIColor+Html.h"
#import "UIColor+HexString.h"
//test

@implementation MMJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //setup navigation controller and put it as a root
//    self.window.rootViewController = self.navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self testColors];
    
    return YES;
}

- (void)testColors
{
    // AliceBlue        #F0F8FF
    // AntiqueWhite 	#FAEBD7
    
    UIColor *aliceBlueImported = [UIColor html_AliceBlue_Color];
    UIColor *aliceBlueFromRGB = [UIColor colorWithHexString:@"#F0F8FF"];
    
    BOOL sameColors1 = [aliceBlueFromRGB isEqual:aliceBlueImported];
    BOOL sameColors2 = [aliceBlueFromRGB isEqualToColor:aliceBlueImported];
    
    NSLog(@"color imported = %@", aliceBlueImported);
    NSLog(@"color from RGB = %@", aliceBlueFromRGB);
    
}

#pragma mark - Properties

- (UINavigationController *)navigationController
{
    if (!_navigationController) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:[[MMJColorPaletteChooserViewController alloc] init]];
    }
    return _navigationController;
}

@end
