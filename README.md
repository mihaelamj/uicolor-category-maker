# uicolor-category-maker
======================

* Tool for generating UIColor category files (h and m) from hex values using text files.
* iOS app for viewing generated colours in table view.

## ColorPaletteCategoryMaker

It parses text file with hex color values and color names, and generates UIColor category interface and implementation files.
Parser is generic and you can subclass it for any specific file format.
Example:
``` objective-c
    NSDictionary *copicColors = [MMJGenericColorParser genericColorsDictionaryWithFileName:@"Copic_Color_HEX_CODE" fileType:@"txt"];
    NSString *filesPath = [MMJColorCategoryWriter makeColorCategoryFilesCategoryName:@"Copic" colorsDictionary:copicColors directory:@"Documents"];
```