//
//  DKViewController.m
//  Created by Dennis Kutlubaev on 27.02.14.
//  This code is distributed under the terms and conditions of the MIT license.
//  Copyright (c) 2014 Dennis Kutlubaev (kutlubaev.denis@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "DKViewController.h"

// You can use these defines to manage colors in hex. It's my present as a bonus to you.
#define RGBA(rgbValue, opacity) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:opacity]

#define RGB(rgbValue) RGBA(rgbValue, 1.0)

#define COLOR_CUSTOM_LIGHT_BLUE RGB(0x3698dc)


// I recommend you to call each button by a name, not by a tag number.
typedef enum ToolbarItems {
    ToolbarItemResponse = 0,
    ToolbarItemNoResumeResponse,
    ToolbarItemMakeCall,
    ToolbarItemAddContact
} ToolbarItem;


@interface DKViewController ()

@property (nonatomic, strong) DKToolbar *toolbar;

@end



@implementation DKViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sample button to test enabling and disabling buttons
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [button setFrame:CGRectMake(20, 200, self.view.frame.size.width - 40, 50)];
    [button setTitle:@"Enable or disable second button" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enableOrDisableSecondButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Sample button to set different number of buttons
    UIButton *setTwoItemsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [setTwoItemsButton setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [setTwoItemsButton setFrame:CGRectMake(20, 250, self.view.frame.size.width - 40, 50)];
    [setTwoItemsButton setTitle:@"Set two items in toolbar" forState:UIControlStateNormal];
    [setTwoItemsButton addTarget:self action:@selector(setTwoItemsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setTwoItemsButton];
    
    // Sample button to set different number of buttons
    UIButton *setFourItemsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [setFourItemsButton setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [setFourItemsButton setFrame:CGRectMake(20, 300, self.view.frame.size.width - 40, 50)];
    [setFourItemsButton setTitle:@"Set four items in toolbar" forState:UIControlStateNormal];
    [setFourItemsButton addTarget:self action:@selector(setFourItemsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setFourItemsButton];

    // Create and add the DKToolbar to your view in ViewDidLoad
    [self setupToolbarWithNumberOfItems:4];
}


// After rotation you need to update item frames in toolbar (probably Autolayout is a better solution)
- (BOOL)shouldAutorotate
{
    // If you support both orientations, you should call this method to update frames of items after the size of DKToolbar has changed.
    [_toolbar updateItemFrames];
    
    return YES;
}


// You can enable or disable any tab whenever you want
- (void)enableOrDisableSecondButtonClicked:(id)sender
{
    DKToolbarItem *secondItem = _toolbar.items[1];
    secondItem.enabled = ! secondItem.enabled;
}


// This method is to test how toolbar with two buttons is created
- (void)setTwoItemsButtonClicked:(id)sender
{
    if (_toolbar) {
        [_toolbar removeFromSuperview];
        _toolbar = nil;
    }
    
    [self setupToolbarWithNumberOfItems:2];
}


// This method is to test how toolbar with four buttons is created
- (void)setFourItemsButtonClicked:(id)sender
{
    if (_toolbar) {
        [_toolbar removeFromSuperview];
        _toolbar = nil;
    }
    
    [self setupToolbarWithNumberOfItems:4];
}


#pragma mark - DKToolbar

- (void)setupToolbarWithNumberOfItems:(int)numberOfItems
{
    NSAssert(_toolbar == nil, @"Method setupToolbar should not be called twice");
    
    // Create and add a toolbar as a subview. It calculates all frames automatically.
    _toolbar = [[DKToolbar alloc] initInView:self.view withDelegate:self];
    _toolbar.itemBackgroundColor = COLOR_CUSTOM_LIGHT_BLUE;
    [self.view addSubview:_toolbar];
    
    //NSLog(@"DKToolbar frame: %@", NSStringFromCGRect(_toolbar.frame));
    
    // Create and add items to the toolbar
    // If selectedImage is nil, button icon will just become gray, when highlighted
    DKToolbarItem *toolbarItem0 = [[DKToolbarItem alloc] initWithTitle:@"Response" image:[UIImage imageNamed:@"VacancyToolbarIconResponse"] selectedImage:nil];
    
    DKToolbarItem *toolbarItem1 = [[DKToolbarItem alloc] initWithTitle:@"No resume" image:[UIImage imageNamed:@"VacancyToolbarIconNoResumeResponse"] selectedImage:nil];

    // You can disable any button by accessing toolbar items directly.
    toolbarItem1.button.enabled = NO;
    
    DKToolbarItem *toolbarItem2 = [[DKToolbarItem alloc] initWithTitle:@"Call" image:[UIImage imageNamed:@"VacancyToolbarIconPhoneCall"] selectedImage:nil];
    
    DKToolbarItem *toolbarItem3 = [[DKToolbarItem alloc] initWithTitle:@"To contacts" image:[UIImage imageNamed:@"VacancyToolbarIconAddContact"] selectedImage:nil];
    
    // This is just for testing different number of items in a toolbar. You should remove NumberOfItems parameter in your realisation.
    if (numberOfItems == 2) {
        _toolbar.items = @[toolbarItem0, toolbarItem1];
    }
    else if (numberOfItems == 4) {
        _toolbar.items = @[toolbarItem0, toolbarItem1, toolbarItem2, toolbarItem3];
    }
}


#pragma mark - DKToolbarDelegate

// Here you can handle clicks on tabs
- (void)toolbarItemClickedAtIndex:(NSInteger)index
{
    NSLog(@"Toolbar item clicked at index:%d", (int)index);
    
    NSString *message = nil;
    
    switch (index) {
        case ToolbarItemResponse:
        {
            message = @"ToolbarItemResponse";
            break;
        }
        case ToolbarItemNoResumeResponse:
        {
            message = @"ToolbarItemResponse";
            break;
        }
        case ToolbarItemMakeCall:
        {
            message = @"ToolbarItemMakeCall";
            break;
        }
        case ToolbarItemAddContact:
        {
            message = @"ToolbarItemAddContact";
            break;
        }
        default:
            break;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Item clicked" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}


@end
