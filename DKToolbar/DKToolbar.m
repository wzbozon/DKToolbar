//
//  DKToolbar.m
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

#import "DKToolbar.h"
#import "DKToolbarItem.h"

@implementation DKToolbar

- (id)initInView:(UIView *)view withDelegate:( id <DKToolbarDelegate> )delegate
{
    NSAssert(view != nil, @"%@: View cannot be nil", [self class]);
    NSAssert(delegate != nil, @"%@: Delegate cannot be nil", [self class]);
    
    CGFloat toolbarHeight = 50.0;
    
    self = [super initWithFrame:CGRectMake(0, view.bounds.size.height - toolbarHeight, view.bounds.size.width, toolbarHeight)];
    
    if ( self ) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        
        _delegate = delegate;
        
        _itemBackgroundColor = [UIColor blackColor];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.autoresizesSubviews = YES;
        
    }
    
    return self;
}


- (void)setItems:(NSArray *)items
{
    _items = items;
    
    [self updateItemFrames];
}


// If you support both orientations, you should call this method to update frames of items after the size of DKToolbar has changed.
- (void)updateItemFrames
{
    for (DKToolbarItem *item in self.items) {
        [item removeFromSuperview];
    }
    
    CGFloat dividerWidth = 1.0;
    CGFloat toolbarHeight = 50.0;
    int numberOfItems = (int)[self.items count];
    int numberOfDividers = numberOfItems - 1;
    CGFloat itemHeight = toolbarHeight;
    CGFloat itemWidth = ( self.bounds.size.width - ( numberOfDividers * dividerWidth ) ) / [self.items count];
    NSInteger i = 0;
    
    for (DKToolbarItem *item in self.items) {
        item.backgroundColor = self.itemBackgroundColor;
        
        CGFloat dx = (itemWidth + dividerWidth) * i;
        [item setFrame:CGRectMake(dx, 0, itemWidth, itemHeight)];
        [item.button addTarget:self action:@selector(toolbarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        i ++;
    }
}


- (void)toolbarItemClicked:(id)sender
{
    UIButton *senderButton = (UIButton *)sender;
    int index = 0;
    
    for (DKToolbarItem *item in self.items) {
        if (item.button == senderButton) {
            break;
        }
        index ++;
    }
    
    [self.delegate toolbarItemClickedAtIndex:index];
}


- (void)setItemBackgroundColor:(UIColor *)itemBackgroundColor
{
    _itemBackgroundColor = itemBackgroundColor;
    
    for (DKToolbarItem *item in self.items) {
        item.backgroundColor = itemBackgroundColor;
    }
}


@end
