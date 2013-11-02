//
//  MMJColorPaletteChooserViewController.m
//  ColorPalettes
//
//  Created by Mihaela Mihaljević Jakić on 02/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorPaletteChooserViewController.h"

#define COLORS_CELL_ID @"colors_cell"

@interface MMJColorPaletteChooserViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *colorPalettes;
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

- (NSMutableArray *)colorPalettes
{
    if (!_colorPalettes) {
        _colorPalettes = [[NSMutableArray alloc] init];
    }
    return  _colorPalettes;
}

- (NSString *)colorPaletteAtIndex:(int)index
{
    return [self.colorPalettes objectAtIndex:index];
}

#pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.colorPalettes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COLORS_CELL_ID];
    
    //set color pallete as cell's text
    cell.textLabel.text = [self.colorPalettes objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get selected view controller
    UIViewController *colorsController = nil;
    if (!colorsController)
        return;
    
    //set selected view conroller's title
    colorsController.title = [self colorPaletteAtIndex:indexPath.row];
    
    //instruct navigation controller to push detail view controller
    [self.navigationController pushViewController:colorsController animated:YES];
}


@end
