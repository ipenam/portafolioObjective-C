//
//  ViewController.m
//  PortafolioObjective-C
//
//  Created by Ivan Peña on 17/03/17.
//  Copyright © 2017 ipenam. All rights reserved.
//

#import "ViewController.h"
#import "HypnosisView.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView{
    UIView  *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = view;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //CGRect firstFrame = CGRectMake(160, 240, 100, 150);
    CGRect firstFrame = self.view.bounds;
    HypnosisView *firstView = [[HypnosisView alloc] initWithFrame:firstFrame];
    //firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    
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
