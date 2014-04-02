//
//  UIButton+Extensions.h
//

// This is a category on UIButton that adds a hitTestEdgeInsets property to make a region of touches for a button bigger
// This solution is taken from Stack Overflow.
// It is a dependency for DKToolbar.

#import <UIKit/UIKit.h>

@interface UIButton (Extensions)

@property (nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end
