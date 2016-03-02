//
//  ViewController.m
//  FileSpace
//
//  Created by Jonathan on 29/02/16.
//  Copyright © 2016 Jonathan. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIButton *pingButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextView *errorTextView;


@end

static int sCount = 0;
static int sSecond = 0;
static int sMilliSecond = 0;

IBOutlet UILabel *mMilliSecondLabel;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addMyButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)aMethod {
    
}

- (void)addMyButton {    // Method for creating button, with background image and other properties
    
    NSLog(@"DEBUG: ViewController#addMyButton()");
    
    // First button
    UIButton *but= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [but setFrame:CGRectMake(-28, 50, 215, 40)];
    [but setTitle:@"Count" forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:20];
    [but setExclusiveTouch:YES];
    but.tag = 26;
    [self.view addSubview:but];
    
    // Fist label: second
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(52, 90, 215, 40)];
    label.text = @"Second";
    label.font = [UIFont systemFontOfSize:20];
    [label setExclusiveTouch:YES];
    label.tag = 27;
    [self.view addSubview:label];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(updateSecond:)
                                   userInfo:nil
                                    repeats:YES];
    
    mMilliSecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(52, 130, 215, 40)];
    mMilliSecondLabel.text = @"MilliSecond";
    mMilliSecondLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:mMilliSecondLabel];
    NSDateFormatter *milliSacondFormatter = [[NSDateFormatter alloc] init];
    [milliSacondFormatter setTimeStyle: NSDateFormatterShortStyle];
    [NSTimer scheduledTimerWithTimeInterval:0.001
                                     target:self
                                   selector:@selector(updateMilliSecond:)
                                   userInfo:nil
                                    repeats:YES];
    
}

-(void) buttonClicked:(UIButton*)sender {
    sCount++;
    NSLog(@"you clicked on button %@ %d", sender.currentTitle, sCount);
    
    for (UIView *i in self.view.subviews){
        if([i isKindOfClass:[UIButton class]]) {
            UIButton *but = (UIButton *) i;
            if(but.tag == 26){
                /// Write your code
                NSMutableString* aString = [NSMutableString stringWithFormat:@"Count %d", sCount];
                // does not need to be released. Needs to be retained if you need to keep use it after the current function.
                [but setTitle:aString forState:UIControlStateNormal];
            }
        }
    }
}

-(void)updateSecond:(id)sender {
    //NSString *currentTime = [dateFormatter stringFromDate: [NSDate date]];
    //timeLabel.text = currentTime;
    
    sSecond++;
    
    for (UIView *i in self.view.subviews){
        if([i isKindOfClass:[UILabel class]]) {
            UILabel *but = (UILabel *) i;
            if(but.tag == 27){
                /// Write your code
                NSMutableString* aString = [NSMutableString stringWithFormat:@"Second %d", sSecond];
                // does not need to be released. Needs to be retained if you need to keep use it after the current function.
                but.text = aString;
            }
        }
    }
}


-(void) updateMilliSecond:(id)sender {
    //NSString *currentTime = [dateFormatter stringFromDate: [NSDate date]];
    //timeLabel.text = currentTime;
    
    sMilliSecond++;
    NSMutableString* aString = [NSMutableString stringWithFormat:@"MilliSecond %d", sMilliSecond];
    // does not need to be released. Needs to be retained if you need to keep use it after the current function.
    mMilliSecondLabel.text = aString;
}

@end
