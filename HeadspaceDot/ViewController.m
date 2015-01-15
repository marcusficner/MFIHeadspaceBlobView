//
//  ViewController.m
//  HeadspaceDot
//
//  Created by Marcus Ficner on 14/01/15.
//  Copyright (c) 2015 Marcus Ficner. All rights reserved.
//

#import "ViewController.h"
#import "MFIHeadspaceBlobView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MFIHeadspaceBlobView *frontView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.frontView.color = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
