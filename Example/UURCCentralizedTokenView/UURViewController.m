//
//  UURViewController.m
//  UURCCentralizedTokenView
//
//  Created by Ugur Cetinkaya on 07/31/2016.
//  Copyright (c) 2016 Ugur Cetinkaya. All rights reserved.
//

#import "UURViewController.h"

#import <UURCCentralizedTokenView/UURCCentralizedTokenView.h>
#import <Masonry/Masonry.h>

@interface UURViewController () <UURCCentralizedTokenViewDelegate>

@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UIImageView *productImage;
@property (nonatomic, strong) UURCCentralizedTokenView *colorsTokenView;
@property (nonatomic, strong) UIButton *addToCartButton;

@end

@implementation UURViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UURCCentralizedTokenView";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *colorArray = @[@"Green", @"Dark Blue", @"Yellow", @"Turquoise", @"Red", @"Dark Brown", @"Blue", @"Amaranth Deep Purple"];
    
    _productNameLabel = [UILabel new];
    [_productNameLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]];
    [_productNameLabel setTextColor:[UIColor colorWithRed:0.72 green:0.11 blue:0.11 alpha:1.0]];
    [self.view addSubview:_productNameLabel];
    [_productNameLabel setText:@"uur® Headphone"];
    
    _productImage = [UIImageView new];
    [_productImage setImage:[UIImage imageNamed:@"headphone"]];
    [self.view addSubview:_productImage];
    
    _colorsTokenView = [[UURCCentralizedTokenView alloc] initWithTokenArray:colorArray];
    _colorsTokenView.parentViewController = self;
    [self.view addSubview:_colorsTokenView];
    
    _addToCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addToCartButton setBackgroundColor:[UIColor colorWithRed:0.72 green:0.11 blue:0.11 alpha:1.0]];
    [_addToCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addToCartButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [self.view addSubview:_addToCartButton];
    [_addToCartButton setTitle:@"Add to cart" forState:UIControlStateNormal];
    
    [self setTokenViewStyle];
    
    [self.view setNeedsUpdateConstraints];
    
    [_colorsTokenView reloadTokens];
}

#pragma mark - UI
- (void)setTokenViewStyle {
    _colorsTokenView.tokenEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
    _colorsTokenView.unselectedTokenTitleColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.11 alpha:1.0];
    _colorsTokenView.selectedTokenTitleColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.11 alpha:1.0];
    _colorsTokenView.selectedTokenColor = [UIColor colorWithRed:1.00 green:0.94 blue:0.67 alpha:1.0];
    _colorsTokenView.selectedTokenBorderColor = [UIColor colorWithRed:1.00 green:0.94 blue:0.67 alpha:1.0];
    _colorsTokenView.unselectedTokenBorderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.11 alpha:1.0];
}

- (void)updateViewConstraints {
    [_productNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(74);
        make.centerX.equalTo(self.view);
    }];
    [_productImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productNameLabel.mas_bottom).offset(5);
        make.centerX.equalTo(self.view);
    }];
    [_colorsTokenView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productImage.mas_bottom).offset(10);
        make.leading.equalTo(self.view).offset(16);
        make.trailing.equalTo(self.view).offset(-16);
    }];
    [_addToCartButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.equalTo(self.view).offset(-15);
        make.height.equalTo(@30);
        make.width.equalTo(@120);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - UURCCentralizedTokenViewDelegate
- (void)actionToken:(NSNumber *)tokenIndex {
    [self.colorsTokenView setTokenSelected:tokenIndex];
    NSLog(@"%@",tokenIndex);
}

@end
