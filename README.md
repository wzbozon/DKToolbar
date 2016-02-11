#DKToolbar

Did you ever want to create a UITabBar like control that doesn't really need UITabBarController? If yes, then this is a solution. Sometimes, designers draw UITabBar without really understanding that it needs tab architecture in the app. I created this control in a such situation. It is a UIView based Toolbar for iOS that looks like UITabBar but doesn't need UITabBarController to be used. Works both on iPhone and iPad in both vertical and horizontal orientations. It stretches automatically to the width of it's parent UIView. Also it has some features that are not present in a classic UITabBar like the possibility to disable some items and to dynamically change number of buttons. It is a subclass of UIView, so you can animate it in a ways you want.

##ScreenShots

<p align="center"><img src="https://github.com/wzbozon/DKToolbar/blob/master/ScreenShots/DKToolbar_horizontal.png?raw=true"></p>

<p align="center"><img src="https://github.com/wzbozon/DKToolbar/blob/master/ScreenShots/DKToolbar_vertical.png?raw=true"></p>

###Supported iOS Versions 
It supports iOS 6.0 and higher.

##How to use

There is a sample project of a universal app for iPhone and iPad.

Best way to add source code is via CocoaPods: 
```
pod 'DKToolbar'
```

Sample Code: 
```
- (void)setupToolbar
{
    // Create and add a toolbar as a subview. It calculates all frames automatically.
    _toolbar = [[DKToolbar alloc] initInView:self.view withDelegate:self];
    _toolbar.itemBackgroundColor = COLOR_CUSTOM_LIGHT_BLUE;
    [self.view addSubview:_toolbar];

    // Create and add items to the toolbar
    DKToolbarItem *toolbarItem0 = [[DKToolbarItem alloc] initWithTitle:@"Response" image:[UIImage imageNamed:@"VacancyToolbarIconResponse"] selectedImage:nil];
    
    DKToolbarItem *toolbarItem1 = [[DKToolbarItem alloc] initWithTitle:@"No resume" image:[UIImage imageNamed:@"VacancyToolbarIconNoResumeResponse"] selectedImage:nil];
    
    DKToolbarItem *toolbarItem2 = [[DKToolbarItem alloc] initWithTitle:@"Call" image:[UIImage imageNamed:@"VacancyToolbarIconPhoneCall"] selectedImage:nil];
   
    DKToolbarItem *toolbarItem3 = [[DKToolbarItem alloc] initWithTitle:@"To contacts" image:[UIImage imageNamed:@"VacancyToolbarIconAddContact"] selectedImage:nil];

    _toolbar.items = @[toolbarItem0, toolbarItem1, toolbarItem2, toolbarItem3];
}


// DKToolbarDelegate

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
``` 