//
//  DKToolbarItem.h
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

#import "DKToolbarItem.h"
#import "UIButton+Extensions.h"


@implementation DKToolbarItem


- (id)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    self = [super initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        self.autoresizesSubviews = YES;
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect buttonFrame = CGRectMake(3, 3, self.frame.size.width, 30);
        [_button setFrame:buttonFrame];
        [_button.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_button setImage:image forState:UIControlStateNormal];
        [_button setImage:selectedImage forState:UIControlStateHighlighted];
        [_button setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
        [_button setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
        [self addSubview:_button];
        
        CGRect labelFrame = CGRectMake(3, self.frame.size.height - 20, self.frame.size.width - 6, 20);
        _label = [[UILabel alloc] initWithFrame:labelFrame];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [_label setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth];
        _label.font = [UIFont systemFontOfSize:10];
        _label.textColor = [UIColor whiteColor];
        _label.text = title;
        [self addSubview:_label];
    }
    
    return self;
}


- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.button.enabled = _enabled;
}


- (BOOL)isEnabled
{
    return self.button.enabled;
}


@end
