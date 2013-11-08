//
//  MMJColorPaletteViewController.m
//  ColorPalettes
//
//  Created by Mihaela Mihaljević Jakić on 02/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorPaletteViewController.h"

#import "UIColor+StandardColors.h"

#import "UIColor+HexString.h"

#define COLOR_TABLE_CELL @"ColorTableCell"

@interface MMJColorPaletteViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSString *paletteName;
@end

@implementation MMJColorPaletteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add tableView to view
    [self.view addSubview:self.tableView];
}

#pragma mark - Properties

- (UITableView *)tableView
{
    if (!_tableView) {
        //create tableView
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        
        //setup table view protocol objects
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        //setup table appearance
        _tableView.rowHeight = 50;
        
        //register reusable cell class ID
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:COLOR_TABLE_CELL];
    }
    return _tableView;
}

- (void)setColors:(NSArray *)colors
{
    _colors = colors;
    [self.tableView reloadData];
}

- (void)setPaletteName:(NSString *)paletteName
{
    _paletteName = paletteName;
    self.title = paletteName;
}

#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.colors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COLOR_TABLE_CELL];
    
    UIColor *cellColor = [self colorAtIndex:indexPath.row];
//    cell.backgroundColor = cellColor;
    cell.contentView.backgroundColor = cellColor;
    
    //set color name and hex string as cell's text
    NSString *justColorName = [self.colors objectAtIndex:indexPath.row];
    justColorName = [self justColorName:justColorName];
    //get hex string from color
    NSString *colorHex = [UIColor hexStringWithColor:cellColor type:HexColorType_RRGGBB];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ [%@]", justColorName, colorHex];
    
    return cell;
}

#pragma mark - Private

- (UIColor *)colorAtIndex:(int)index
{
   return [UIColor colorFromName:self.colors[index]];
}

- (NSString *)justColorName:(NSString *)colorSelectorName
{
    NSString *paletteName = [NSString stringWithFormat:@"%@_", self.paletteName];
    NSRange palleteNameRange = [colorSelectorName rangeOfString:paletteName];
    
    NSRange colorRange = [colorSelectorName rangeOfString:@"_Color"];
    
    NSRange colorNameRange = NSMakeRange(palleteNameRange.length, colorRange.location - palleteNameRange.length);
    return [colorSelectorName substringWithRange:colorNameRange];
}


@end
