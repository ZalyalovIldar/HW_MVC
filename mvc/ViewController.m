//
//  ViewController.m
//  Window
//
//  Created by  Ildar on 12.11.14.
//  Copyright (c) 2014  Ildar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISwitch *boolSw;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segC;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSData *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    if (color)
        self.button.backgroundColor = [NSKeyedUnarchiver unarchiveObjectWithData:color];
    else
    {
        self.button.backgroundColor = [UIColor whiteColor];
    }
    
    NSNumber *switchKey=@0;
    switchKey= [[NSUserDefaults standardUserDefaults] objectForKey:@"switch"];
    [self.boolSw setOn:switchKey.boolValue animated:NO];
    
    NSString *textField = [[NSUserDefaults standardUserDefaults] objectForKey:@"textField"];
    if (textField)
        self.textField.text = textField;
    else
    {
        self.textField.text = @"";
    }
    
    NSNumber *segC=@0;
    segC = [[NSUserDefaults standardUserDefaults]objectForKey:@"segment"];
    self.segC.selectedSegmentIndex = segC.integerValue;
    
    NSNumber *location=@1;
    location = [[NSUserDefaults standardUserDefaults] objectForKey:@"sliderValue"];
self.slider.value = location.floatValue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)button:(id)sender {
    UIColor *randC = [self randColor];
    self.button.backgroundColor = randC;
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:randC] forKey:@"color"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)segM:(id)sender {
    NSInteger segmentC= self.segC.selectedSegmentIndex;
    [[NSUserDefaults standardUserDefaults] setObject:@(segmentC) forKey:@"segment"];
}

- (IBAction)slider:(id)sender {
    float sliderV = self.slider.value;
    [[NSUserDefaults standardUserDefaults] setObject:@(sliderV) forKey:@"sliderValue"];
}

- (IBAction)boolSw:(id)sender {
    int ss = self.boolSw.isOn;
   [[NSUserDefaults standardUserDefaults] setObject:@(ss) forKey:@"switch"];
}


- (IBAction)textField:(UITextField *)sender {
    NSString *text= self.textField.text;
    [[NSUserDefaults standardUserDefaults] setObject:text forKey:@"textField"];
}


-(UIColor *)randColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

@end
