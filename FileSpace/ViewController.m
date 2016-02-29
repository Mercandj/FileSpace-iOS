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

static int theCount = 0;

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

- (void)aMethod{
    
}

- (void)addMyButton{    // Method for creating button, with background image and other properties
    
    NSLog(@"DEBUG: ViewController#addMyButton()");
    
    UIButton *but= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [but addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [but setFrame:CGRectMake(72, 252, 215, 40)];
    [but setTitle:@"Count" forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:24];
    [but setExclusiveTouch:YES];
    but.tag = 26;
    
    [self.view addSubview:but];
}

-(void) buttonClicked:(UIButton*)sender {
    theCount++;
    NSLog(@"you clicked on button %@ %d", sender.currentTitle, theCount);
    
    for (UIView *i in self.view.subviews){
        if([i isKindOfClass:[UIButton class]]){
            UIButton *but = (UIButton *)i;
            if(but.tag == 26){
                /// Write your code
                NSMutableString* aString = [NSMutableString stringWithFormat:@"Count %d", theCount];
                // does not need to be released. Needs to be retained if you need to keep use it after the current function.
                [but setTitle:aString forState:UIControlStateNormal];
            }
        }
    }
}


@end
