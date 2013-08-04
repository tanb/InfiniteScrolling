//
//  DatePickerExperimentViewController.m
//  InfiniteScrolling
//
//  Created by tanB on 8/2/13.
//  Copyright (c) 2013 tanB. All rights reserved.
//

#import "DatePickerExperimentViewController.h"

@interface DatePickerExperimentViewController ()

@end

@implementation DatePickerExperimentViewController {
    IBOutlet UIDatePicker *_datePicker;
    IBOutlet UILabel *_numOfRows;
    IBOutlet UILabel *_selectedIndex;
    
    BOOL _toggleFlag;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _toggleFlag = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIDatePicker
    [self dumpSubviews:_datePicker];
    
    // ex.1
    [self experimentNumberOfRowsInColumn];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // ex.2
    [self experimentSelectedRowForColumn:_datePicker];
}

- (void)experimentNumberOfRowsInColumn
{
    UIView *datePickerView = [self datePickerView];
    NSInteger column = 2;
    SEL sel = NSSelectorFromString(@"numberOfRowsInColumn:");
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[datePickerView methodSignatureForSelector:sel]];
    [inv setSelector:sel];
    [inv setTarget:datePickerView];
    [inv setArgument:&column atIndex:2];
    [inv invoke];
    NSUInteger length = [[inv methodSignature] methodReturnLength];
    NSInteger buffer = (NSInteger)malloc(length);
    [inv getReturnValue:&buffer];
    _numOfRows.text = [NSString stringWithFormat:@"%d", buffer];
}

- (IBAction)experimentSelectedRowForColumn:(id)sender
{
    UIView *datePickerView = [self datePickerView];
    NSInteger column = 2;
    SEL sel = NSSelectorFromString(@"selectedRowForColumn:");
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[datePickerView methodSignatureForSelector:sel]];
    [inv setSelector:sel];
    [inv setTarget:datePickerView];
    [inv setArgument:&column atIndex:2];
    [inv invoke];
    NSUInteger length = [[inv methodSignature] methodReturnLength];
    NSInteger buffer = (NSInteger)malloc(length);
    [inv getReturnValue:&buffer];
    _selectedIndex.text = [NSString stringWithFormat:@"%d", buffer];
}

- (IBAction)experimentSelectRowInColumnAnimated:(id)sender
{
    NSInteger row = 0;
    if (_toggleFlag) {
        row = 99999;
    }
    _toggleFlag = !_toggleFlag;

    UIView *datePickerView = [self datePickerView];
    NSInteger column = 2;
    BOOL anim = YES;
    SEL sel = NSSelectorFromString(@"selectRow:inColumn:animated:");
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:[datePickerView methodSignatureForSelector:sel]];
    [inv setSelector:sel];
    [inv setTarget:datePickerView];
    [inv setArgument:&row atIndex:2];
    [inv setArgument:&column atIndex:3];
    [inv setArgument:&anim atIndex:4];
    [inv invoke];
    
    // update label _selectedIndex
    [self experimentSelectedRowForColumn:sender];
}

- (id)datePickerView
{
    for (UIView *subview in _datePicker.subviews) {
        if ([subview isMemberOfClass:NSClassFromString(@"_UIDatePickerView")]) {
            return subview;
        }
    }
    return nil;
}


- (void)dumpSubviews:(UIView *)view
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSLog(@"%@", [view performSelector:NSSelectorFromString(@"recursiveDescription")]);
#pragma clang diagnostic pop    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
