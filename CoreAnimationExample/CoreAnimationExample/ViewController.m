//
//  ViewController.m
//  CoreAnimationExample
//
//  Created by aa on 10/6/15.
//  Copyright (c) 2015 aa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIView * theLayer = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-20, 200, 200)];
    [theLayer setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:theLayer];
    
   
    [UIView animateWithDuration:3.0 animations:^{
        // Change the opacity implicitly.
       
        CABasicAnimation *resizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
        [resizeAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(theLayer.frame.size.width, theLayer.frame.size.height * 10)]];
        resizeAnimation.fillMode = kCAFillModeForwards;
        resizeAnimation.duration = 0.1;
        resizeAnimation.beginTime = 0.1;
        resizeAnimation.removedOnCompletion = YES;

        CABasicAnimation *resizeAnimation1 = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
        [resizeAnimation1 setToValue:[NSValue valueWithCGSize:CGSizeMake(theLayer.frame.size.width, theLayer.frame.size.height)]];
        resizeAnimation1.fillMode = kCAFillModeForwards;
        resizeAnimation1.duration = 0.25;
        resizeAnimation1.beginTime = 0.2;
        resizeAnimation1.removedOnCompletion = YES;
        
        CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [fadeInAnimation setToValue:[NSNumber numberWithFloat:100]];
        fadeInAnimation.fillMode = kCAFillModeForwards;
        fadeInAnimation.removedOnCompletion = NO;
        fadeInAnimation.duration = 1.8;
        fadeInAnimation.beginTime = 0.8;
        
        CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        [fadeOutAnimation setToValue:[NSNumber numberWithFloat:10]];
        fadeOutAnimation.fillMode = kCAFillModeForwards;
        fadeOutAnimation.removedOnCompletion = NO;
        fadeOutAnimation.duration = 0.2;


        
        
        // create a CGPath that implements two arcs (a bounce)
        CGMutablePathRef thePath = CGPathCreateMutable();
        CGPathMoveToPoint(thePath,NULL,self.view.frame.size.width/2,self.view.frame.size.height+20);
        CGPathAddCurveToPoint(thePath,NULL,self.view.frame.size.width/2,self.view.frame.size.height+20,
                              self.view.frame.size.width/2,40,
                              self.view.frame.size.width/2,40);

        CGPathMoveToPoint(thePath,NULL,self.view.frame.size.width/2,120);
        
        CGPathAddCurveToPoint(thePath,NULL,self.view.frame.size.width/2,120,
                              self.view.frame.size.width/2,0,
                              self.view.frame.size.width/2,120);

        CGPathAddCurveToPoint(thePath,NULL,self.view.frame.size.width/2,120,
                              self.view.frame.size.width/2,170,
                              self.view.frame.size.width/2,120);
        
        CAKeyframeAnimation * theAnimation;
        
        // Create the animation object, specifying the position property as the key path.
        theAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
        theAnimation.path=thePath;
        theAnimation.duration=1.15;
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animation.duration = 0.6;
        animation.beginTime = 0.3f;
        animation.values = @[ @(-70), @(70), @(-50), @(50), @(-30), @(30),@(-30), @(30),@(-30), @(30),@(-20), @(20), @(-15), @(15),@(-20), @(20),@(-20), @(20),@(-20), @(20),@(-20), @(20),@(-10), @(10),@(-10), @(10),@(-10), @(10),@(-8), @(8),@(-8), @(8),@(5), @(5), @(0) ];
        
        
        
        
        // Animation group
        CAAnimationGroup* group = [CAAnimationGroup animation];
        group.animations = [NSArray arrayWithObjects:theAnimation, animation, resizeAnimation,resizeAnimation1,fadeOutAnimation,fadeInAnimation, nil];
        group.duration = 2.0;
        
        [theLayer.layer addAnimation:group forKey:@"BorderChanges"];
        
    }completion:^(BOOL finish){
        if (finish) {
            [theLayer setFrame:CGRectMake(self.view.frame.size.width/2-100, 10, 200, 200)];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
