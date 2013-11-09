# uicolor-category-maker
======================

* Tool for generating UIColor category files (h and m) from hex values using text files.
* iOS app for viewing generated colours in table view.

## Generated Categories
* [UIColor+Copic](https://github.com/mihaelamj/uicolor-copic "Copic markers colors category")
* [UIColor+HTML](https://github.com/mihaelamj/uicolor-html "HTML named colors category")
* [UIColor+Crayola](https://github.com/mihaelamj/uicolor-crayola "Crayola crayon colors category")
* [UIColor+Pantone](https://github.com/mihaelamj/uicolor-pantone"Pantone colors category")

## ColorPaletteCategoryMaker

It parses text file with hex color values and color names, and generates UIColor category interface and implementation files.
Parser is generic and you can subclass it for any specific file format.

### Ho to make colors:

* Find colour hex codes with names somewhere on the web..(like http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors)
* Copy the text into text file, (Copic_Color_HEX_CODE.txt)
* Add the text file to project and write the code like this:

``` objective-c
//makes dictionary of <color name> : <color components dictionary>
NSDictionary *copicColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"Copic_Color_HEX_CODE" fileType:@"txt"];

//makes UIColor+Copic.h & UIColor+Copic.m files from dictionary
NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"Copic" colorsDictionary:copicColors directory:@"Documents"];

NSLog(@"files written to /n%@", filesPath);
```
* UIColor+<category name>.h & UIColor+<category name>.m files will be generated, and the path printed in console.

##ColorPalletes
 iOS project for viewing generated colour category colours, names and hex values.
Just add the generated category files to the project.
* Included example categories
1. UIColor+Copic : Copic markers colors
2. UIColor+Crayola : Crayola colors
3. UIColor+Html : named HTML colours
4. UIColor+Pantone : all Pantone colors
