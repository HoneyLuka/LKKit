//
//  LKKitDefines.m
//  LKKit
//
//  Created by Selina on 25/12/2020.
//

#import "LKKitDefines.h"

void lk_no_anim_block(LKVoidBlock block) {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    block();
    [CATransaction commit];
}

void lk_fade_transition(NSTimeInterval duration, UIView *view, LKVoidBlock block) {
    block();
    CATransition *transition = [CATransition new];
    transition.duration = duration;
    [view.layer addAnimation:transition forKey:@"app_fade_transition"];
}

void lk_ui_fade_in(NSTimeInterval duration, UIView *view) {
    view.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 1;
    }];
}

void lk_ui_fade_out(NSTimeInterval duration, UIView *view) {
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 0;
    }];
}
