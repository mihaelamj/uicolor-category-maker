//
//  MMJColorPaletteViewController.m
//  ColorPalettes
//
//  Created by Mihaela Mihaljević Jakić on 02/11/13.
//  Copyright (c) 2013 Token d.o.o. All rights reserved.
//

#import "MMJColorPaletteViewController.h"

#define COLOR_TABLE_CELL @"ColorTableCell"

@interface MMJColorPaletteViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *colors;
@end

@implementation MMJColorPaletteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

- (NSMutableArray *)colors
{
    if (!_colors) {
        _colors = [[NSMutableArray alloc] init];

        [self.tableView reloadData];
    }
    return _colors;
}


@end
