//
//  ViewController.m
//  QQMusicTransitionAnimation
//
//  Created by 张德荣 on 16/4/4.
//  Copyright © 2016年 JsonZhang. All rights reserved.
//

#import "TransitionFromFirstToSecond.h"

#import "ViewController.h"
#import "SecondViewController.h"

@implementation TransitionFromFirstToSecond

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
    
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UINavigationController *nav = (UINavigationController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *fromViewController = (ViewController *)nav.topViewController;
    SecondViewController *toViewController = (SecondViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    UIView *cellImageSnapshot = [fromViewController.imageView snapshotViewAfterScreenUpdates:YES];
    
    cellImageSnapshot.frame = [containerView convertRect:fromViewController.imageView.frame fromView:fromViewController.containerView];
    fromViewController.imageView.hidden = YES;
    
   
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.secondImageview.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        
        toViewController.view.alpha = 1.0;
        
        
        CGRect frame = [containerView convertRect:toViewController.secondImageview.frame fromView:toViewController.view];
//        NSLog(@"frame is %@",NSStringFromCGRect(toViewController.secondImageview.frame));
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        
        toViewController.secondImageview.hidden = NO;
        fromViewController.imageView.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
      
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}@end
