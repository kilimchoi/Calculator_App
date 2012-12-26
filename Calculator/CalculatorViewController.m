//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ki Lim Choi on 12/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController() 
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end


@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}


- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [[sender titleLabel] text];
    NSRange range = [[display text] rangeOfString:@"."];
    if (userIsInTheMiddleOfEnteringANumber) 
    {
        if ( ! ([digit isEqual:@"."] && (range.location != NSNotFound))) { //returns true if "." found the first time. returns false if "." found in the consecutive stages. 
            [display setText:[[display text] stringByAppendingFormat:digit]];
        }
    }
    else //if user inputs for the first time.
    {
        if ([digit isEqual:@"."]) {
            [display setText: @"0."];
        }
        else {
            [display setText: digit];
        }
        
        userIsInTheMiddleOfEnteringANumber = YES;
        
    }

}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

@end
