//
//  MMJColorPaletteChooserViewController.m
//  ColorPalettes
//
//  Created by Mihaela Mihaljević Jakić on 02/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorPaletteChooserViewController.h"

//detail view controller
#import "MMJColorPaletteViewController.h"

//all palettes/categories
#import "MMJColorPalettes.h"

#define COLORS_CELL_ID @"colors_cell"

@interface MMJColorPaletteChooserViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MMJColorPalettes *colorPalettes;
@property (nonatomic, strong) MMJColorPaletteViewController *colorsViewController;
@end

@implementation MMJColorPaletteChooserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // add tableView to view
    [self.view addSubview:self.tableView];
    //set title
    self.title = @"Color Palettes";
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:COLORS_CELL_ID];
    }
    return _tableView;
}

- (MMJColorPalettes *)colorPalettes
{
    if (!_colorPalettes) {
        _colorPalettes = [[MMJColorPalettes alloc] init];
    }
    return  _colorPalettes;
}

- (NSString *)colorPaletteAtIndex:(int)index
{
    return [self.colorPalettes.palletes objectAtIndex:index];
}

- (MMJColorPaletteViewController *)colorsViewController
{
    if (!_colorsViewController) {
        _colorsViewController = [[MMJColorPaletteViewController alloc] init];
    }
    return _colorsViewController;
}

#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.colorPalettes.palletes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COLORS_CELL_ID];
    
    //set color pallete as cell's text
    cell.textLabel.text = [self colorPaletteAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * pallete = [self colorPaletteAtIndex:indexPath.row];
    
    //re-create detail VC
    self.colorsViewController = nil;
    
    // set detail VC title
    if ([self.colorsViewController respondsToSelector:@selector(setPaletteName:)]) {
        [self.colorsViewController setPaletteName:pallete];
    }
    
    //get all color method names for pallete
    NSArray *palleteColors = [self.colorPalettes colorsForPalette:pallete];
    //give color method names to child VC
    if ([self.colorsViewController respondsToSelector:@selector(setColors:)]) {
        [self.colorsViewController setColors:palleteColors];
    }
    
    //instruct navigation controller to push detail view controller
    [self.navigationController pushViewController:self.colorsViewController animated:YES];
}


@end
