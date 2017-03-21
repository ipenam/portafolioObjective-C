//
//  HypnosisView.m
//  PortafolioObjective-C
//
//  Created by Ivan Peña on 17/03/17.
//  Copyright © 2017 ipenam. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect bounds = self.bounds;
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [UIBezierPath new];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius // Note this is currentRadius!
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    path.lineWidth = 10.0;
    
    [[UIColor lightGrayColor] setStroke];
    
    [path stroke];
    
    //Shadows for logo
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4,7), 3);
    
    UIImage *logoImage = [UIImage imageNamed:@"DoorsLogo.png"];
    [logoImage drawInRect:CGRectMake(center.x - logoImage.size.width/8.0, center.y - logoImage.size.height/8.0, logoImage.size.width/4.0, logoImage.size.height/4.0)];
}


@end
