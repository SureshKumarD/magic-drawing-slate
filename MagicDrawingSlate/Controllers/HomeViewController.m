//
//  HomeViewController.m
//  MagicDrawingSlate
//
//  Created by Suresh on 12/5/16.
//  Copyright © 2016 Suresh. All rights reserved.
//

#import "HomeViewController.h"
#import "DrawingView.h"

@interface HomeViewController ()
@property (nonatomic, strong) DrawingView *drawingView;
@end

@implementation HomeViewController

- (void)loadView {
    _drawingView = [[DrawingView alloc] init];
    _drawingView.backgroundColor = [UIColor whiteColor];
    self.view = _drawingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
