//
//  MBViewController.m
//  MBSwitchDemo
//
//  Created by Mathieu Bolard on 22/06/13.
//  Copyright (c) 2013 Mathieu Bolard. All rights reserved.
//

#import "MBViewController.h"
#import "MBDemoAppearanceContainer.h"

@interface MBViewController () {
}

@end

@implementation MBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    MBSwitch *switchAppearanceProxy = [MBSwitch appearanceWhenContainedIn:[MBDemoAppearanceContainer class], nil];
    
    [switchAppearanceProxy setTintColor:[UIColor yellowColor]];
    [switchAppearanceProxy setOnTintColor:[UIColor orangeColor]];
    
    self.mbswitch2 = [[MBSwitch alloc] initWithFrame:CGRectMake(20.0, 129.0, 51.0, 31.0)];
    [_mbswitch2 setOnTintColor:[UIColor colorWithRed:0.23f green:0.35f blue:0.60f alpha:1.00f]];
    [_mbswitch2 setTintColor:[UIColor colorWithRed:0.91f green:0.30f blue:0.24f alpha:1.00f]];
    [self.view addSubview:_mbswitch2];
    
    [_mbswitch3 setTintColor:[UIColor colorWithRed:0.58f green:0.65f blue:0.65f alpha:1.00f]];
    [_mbswitch3 setOnTintColor:[UIColor colorWithRed:0.91f green:0.30f blue:0.24f alpha:1.00f]];
    [_mbswitch3 setOffTintColor:[UIColor colorWithRed:0.93f green:0.94f blue:0.95f alpha:1.00f]];
    
    [_mbswitch4 setTintColor:[UIColor colorWithRed:0.74f green:0.76f blue:0.78f alpha:1.00f]];
    [_mbswitch4 setOnTintColor:[UIColor colorWithRed:0.20f green:0.60f blue:0.86f alpha:1.00f]];
    [_mbswitch4 setOffTintColor:[UIColor colorWithRed:0.20f green:0.29f blue:0.37f alpha:1.00f]];
    
    //[_mbswitch addTarget:self action:@selector(switchT:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchT:(UISwitch *)sender {
    [_mbswitch setOn:sender.isOn animated:YES];
    [_mbswitch2 setOn:sender.isOn animated:YES];
    [_mbswitch3 setOn:sender.isOn animated:YES];
    [_mbswitch4 setOn:sender.isOn animated:YES];
}

- (IBAction)switchD:(UISwitch *)sender {
    [_mbswitch setOn:sender.isOn];
    [_mbswitch2 setOn:sender.isOn];
    [_mbswitch3 setOn:sender.isOn];
    [_mbswitch4 setOn:sender.isOn];
}

- (void) dealloc {
    [_mbswitch2 release], _mbswitch2 = nil;
    [super dealloc];
}

@end
