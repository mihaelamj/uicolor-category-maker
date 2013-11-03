# uicolor-category-maker
======================

* Tool for generating UIColor category files (h and m) from hex values using text files.
* iOS app for viewing generated colours in table view.

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
* iOS project for viewing generated colour category colours, names and hex values.
* Included example categories :
1. UIColor+Copic : Copic markers colors
2. UIColor+Crayola : Crayola colors
3. UIColor+Html : named HTML colours
4. UIColor+Pantone : all Pantone colors
