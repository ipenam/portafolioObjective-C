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
    
    /*
    CGRect firstFrame = self.view.bounds;
    HypnosisView *firstView = [[HypnosisView alloc] initWithFrame:firstFrame];
    [self.view addSubview:firstView];
     */
    
    CGRect screenRect   = self.view.bounds;
    CGRect bigRect      = screenRect;
    
    bigRect.size.width  *= 2.0;
    bigRect.size.height *= 1.0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:hypnosisView];
    
    screenRect.origin.x += screenRect.size.width;
    HypnosisView *hypnosisView2 = [[HypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:hypnosisView2];
    
    scrollView.contentSize = bigRect.size;
    
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
