//
//  PairTableViewCell.m
//  PairRandomizer-ObjC
//
//  Created by TRM on 7/8/15.
//  Copyright (c) 2015 MottApplications. All rights reserved.
//

#import "PairTableViewCell.h"
#import "UIView+FLKAutoLayout.h"

@implementation PairTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.label1 = [UILabel new];
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.label1.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.label1];
        
        self.label2 = [UILabel new];
        self.label2.textAlignment = NSTextAlignmentCenter;
        self.label2.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.label2];
        
        self.contentView.backgroundColor = [UIColor blackColor];
        
        [self.label1 alignCenterYWithView:self.contentView predicate:@"0"];
        [self.label1 alignLeadingEdgeWithView:self.contentView predicate:@"5"];
        [self.label1 constrainWidthToView:self.contentView predicate:@"*.5-7.5"];
        
        [self.label2 alignCenterYWithView:self.contentView predicate:@"0"];
        [self.label2 alignTrailingEdgeWithView:self.contentView predicate:@"-5"];
        [self.label2 constrainWidthToView:self.contentView predicate:@"*.5-7.5"];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
