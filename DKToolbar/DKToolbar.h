//
//  DKToolbar.h
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
// This is a custom ToolBar control, that looks like UITabBar. The reasoning behind creating such a control is that standart UITabBar can be used only within UITabBarController. The standart UIToolbar does not have labels under icons and the space between buttons is not like in UITabBar.

// Disclaimer: I do not recommend to use it all the time instead of UITabBar ! Only when appropriate.

// Advantages:

// * You can enable or disable any tab whenever you want

// * You can change the number of tabs in DKToolbar in runtime

// * You do not need to use UITabBarController to add UITabBar to your view

// * You can customize and animate DKToolbar since it is open source and it is a simple UIView


#import <Foundation/Foundation.h>

#import "DKToolbarItem.h"

@protocol DKToolbarDelegate <NSObject>

- (void)toolbarItemClickedAtIndex:(NSInteger)index;

@end


@interface DKToolbar : UIView {
    
    id <DKToolbarDelegate> _delegate;
    
}

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIColor *itemBackgroundColor;

// Creates and adds a toolbar as a subview to your view. It calculates all frames automatically.
- (id)initInView:(UIView *)view withDelegate:( id <DKToolbarDelegate> )delegate;

// If you support both orientations or a resizement of a parent view, you should call this method to update frames of items after the size of DKToolbar has changed. DKToolBar stretches in a parent view automatically, but frames of items should be recalculated.
- (void)updateItemFrames;

@end
