//
//  UURCCentralizedTokenView.m
//  ceuur
//
//  Created by Ugur Cetinkaya on 03/02/16.
//  Copyright © 2016 Ugur Cetinkaya All rights reserved.
//

#import "UURCCentralizedTokenView.h"

static const CGFloat kDefaulTokenViewLeftPadding = 16.0;
static const CGFloat kDefaulTokenViewRightPadding = 16.0;
static const CGFloat kDefaulTokenPadding = 10.0;
static const CGFloat kDefaulUnselectedTokenRadius = 13.0;

typedef struct {
    int numOfButton;
    float width;
    float height;
} TokenRow;

@interface UURCCentralizedTokenView()

@property (nonatomic, strong) NSArray *tokenArray;
@property (nonatomic, strong) NSMutableArray *tokenButtons;

- (void)setDefaultSyle;

@end

@implementation UURCCentralizedTokenView

- (instancetype)initWithTokenArray:(NSArray *)tokenArray {
    self = [super init];
    if (!self) {
     return nil;   
    }
    
    self.tokenArray = [[NSArray alloc] initWithArray:tokenArray];
    self.tokenButtons = [NSMutableArray new];
    [self setDefaultSyle];
    
    return self;
}

- (void)reloadTokens {
    [self removeTokens];
    NSArray *rows = [self getTokensButtonsRow];
    int tokenIndex = 0;
    for (int index = 0; index < rows.count ; index++) {
        UIView *tokenButtonsRow = [UIView new];
        [self addSubview:tokenButtonsRow];
        tokenButtonsRow.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSValue *value = [rows objectAtIndex:index];
        TokenRow tokenRow;
        [value getValue:&tokenRow];
        
        float buttonLeadingOffset = 0;
        for (int i = 0; i < tokenRow.numOfButton; i++) {
            UIButton *button = [self getTokenButtonWith:self.tokenArray[tokenIndex]];
            button.tag = tokenIndex;
            [tokenButtonsRow addSubview:button];
            button.translatesAutoresizingMaskIntoConstraints = NO;
            
            [button addTarget:self action:@selector(actionToken:) forControlEvents:UIControlEventTouchUpInside];
            
            [tokenButtonsRow addConstraints:@[[NSLayoutConstraint constraintWithItem:button
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:tokenButtonsRow
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0
                                                                              constant:0],
                                                
                                                [NSLayoutConstraint constraintWithItem:button
                                                                             attribute:NSLayoutAttributeBottom
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:tokenButtonsRow
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:0],
                                                
                                                [NSLayoutConstraint constraintWithItem:button
                                                                             attribute:NSLayoutAttributeLeft
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:tokenButtonsRow
                                                                             attribute:NSLayoutAttributeLeft
                                                                            multiplier:1
                                                                              constant:(buttonLeadingOffset + i * self.tokenPadding)]
                                                ]];
            buttonLeadingOffset += button.frame.size.width;
            [self.tokenButtons addObject:button];
            tokenIndex ++;
        }
        
        [self addConstraints:@[[NSLayoutConstraint constraintWithItem:tokenButtonsRow
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:(index * (tokenRow.height + self.tokenPadding))],
                               
                               [NSLayoutConstraint constraintWithItem:tokenButtonsRow
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:tokenRow.width],
                               
                               [NSLayoutConstraint constraintWithItem:tokenButtonsRow
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0]
                               ]];
        NSLayoutConstraint *bottomConstrait = [NSLayoutConstraint constraintWithItem:tokenButtonsRow
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0
                                                                            constant:0];
        if (index == rows.count -1) {
            [self addConstraint:bottomConstrait];
        }
    }
    [self setTokenSelected:@0];
}


- (NSArray *)getTokensButtonsRow{
    NSMutableArray * row = [NSMutableArray new];
    float rowWidth = 0;
    int numOfButton = 0;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    for (int index = 0; index < self.tokenArray.count; index ++) {
        UIButton *button = [self getTokenButtonWith:self.tokenArray[index]];
        float buttonWidth = button.frame.size.width;
        rowWidth += buttonWidth;
        if (rowWidth > (screenWidth - (self.tokenViewLeftPadding + self.tokenViewRightPadding))) {
            [row addObject:[self addableTokenRowStructWith:numOfButton width:(rowWidth - buttonWidth - self.tokenPadding) height:button.frame.size.height]];
            numOfButton = 1;
            rowWidth = buttonWidth;
        }
        else {
            numOfButton++;
        }
        if (index == self.tokenArray.count -1) {
            [row addObject:[self addableTokenRowStructWith:numOfButton width:rowWidth height:button.frame.size.height]];
        }
        rowWidth += self.tokenPadding;
    }
    return row;
}

- (UIButton *)getTokenButtonWith:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:self.unselectedTokenColor];
    [button.layer setBorderColor:self.unselectedTokenBorderColor.CGColor];
    [button.layer setBorderWidth:.5];
    [button.layer setCornerRadius:13];
    [button.titleLabel setFont:self.unselectedTokenFont];
    [button setTitleColor:self.unselectedTokenTitleColor forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%@", title] forState:UIControlStateNormal];
    [button setContentEdgeInsets:self.tokenEdgeInsets];
    [button sizeToFit];
    
    return button;
}

- (NSValue *)addableTokenRowStructWith:(int)numOfButton width:(float)width height:(float)height{
    TokenRow tokenRow;
    tokenRow.numOfButton = numOfButton;
    tokenRow.width = width;
    tokenRow.height = height;
    return [NSValue value:&tokenRow withObjCType:@encode(TokenRow)];
}

- (void)setTokenSelected:(NSNumber *)tokenIndex {
    UIButton *button;
    for (UIButton *tokenButton in self.tokenButtons) {
        [tokenButton setBackgroundColor:self.unselectedTokenColor];
        [tokenButton setTitleColor:self.unselectedTokenTitleColor forState:UIControlStateNormal];
        [tokenButton.layer setBorderColor:self.unselectedTokenBorderColor.CGColor];
        if (tokenButton.tag == tokenIndex.integerValue) {
            button = tokenButton;
        }
    }
    
    [button setBackgroundColor:self.selectedTokenColor];
    [button.layer setBorderColor:self.selectedTokenBorderColor.CGColor];
    [button setTitleColor:self.selectedTokenTitleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:self.selectedTokenFont];
}

- (void)removeTokens {
    for (UIView *subUIView in self.subviews) {
        [subUIView removeFromSuperview];
    }
}

- (void)setDefaultSyle {
    self.tokenViewLeftPadding = kDefaulTokenViewLeftPadding;
    self.tokenViewRightPadding = kDefaulTokenViewRightPadding;
    self.tokenPadding = kDefaulTokenPadding;
    
    self.tokenEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    
    self.unselectedTokenColor = [UIColor whiteColor];
    self.unselectedTokenBorderColor = [UIColor blackColor];
    self.unselectedTokenTitleColor = [UIColor redColor];
    self.unselectedTokenRadius = kDefaulUnselectedTokenRadius;
    self.unselectedTokenFont = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
    
    self.selectedTokenColor = [UIColor yellowColor];
    self.selectedTokenBorderColor = [UIColor blackColor];
    self.selectedTokenTitleColor = [UIColor redColor];
    self.selectedTokenRadius = kDefaulUnselectedTokenRadius;
    self.selectedTokenFont = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
}

#pragma mark - Actions
- (void)actionToken:(id)sender {
    UIButton *button = (UIButton *)sender;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([self.parentViewController respondsToSelector:@selector(actionToken:)])
        [self.parentViewController performSelector:@selector(actionToken:) withObject:@(button.tag)];
#pragma clang diagnostic pop

}

@end
