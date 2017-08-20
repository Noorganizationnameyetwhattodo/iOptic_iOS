//
//  YTableViewCell.m
//  iOptic
//
//  Created by Santhosh on 11/07/17.
//  Copyright © 2017 mycompany. All rights reserved.
//

#import "YTableViewCell.h"

@implementation YTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.containerForLabels.layer setCornerRadius:5.0f];
    
    [self.containerForLabels.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.containerForLabels.layer setBorderWidth:1.5f];
    
    [self.containerForLabels.layer setShadowColor:[UIColor blackColor].CGColor];
    
    [self.containerForLabels.layer setShadowOpacity:0.8];
    
    [self.containerForLabels.layer setShadowRadius:3.0];
    
    [self.containerForLabels.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateDetails:(NSDictionary*)prescriptionDetails
{
    
    self.lensTypeLbl.text = [prescriptionDetails valueForKey:@"Type"];
    if ([prescriptionDetails valueForKey:@"power"]){
        self.powerLeft.text = [[prescriptionDetails valueForKey:@"power"] valueForKey:@"os"];
        self.powerRight.text = [[prescriptionDetails valueForKey:@"power"] valueForKey:@"od"];
    }
    if ([prescriptionDetails valueForKey:@"bc"]){
        self.bcRight.text = [[prescriptionDetails valueForKey:@"bc"] valueForKey:@"od"];
        self.bcLeft.text = [[prescriptionDetails valueForKey:@"bc"] valueForKey:@"os"];
    }
    
    if ([prescriptionDetails valueForKey:@"dia"]){
        self.diaRight.text = [[prescriptionDetails valueForKey:@"dia"] valueForKey:@"od"];
        self.diaLeft.text = [[prescriptionDetails valueForKey:@"dia"] valueForKey:@"os"];
    }else{
        self.diaRight.text = @"-";
        self.diaLeft.text = @"-";
    }
    
    if ([prescriptionDetails valueForKey:@"axis"]){
        self.axisRight.text = [[prescriptionDetails valueForKey:@"axis"] valueForKey:@"od"];
        self.axisLeft.text = [[prescriptionDetails valueForKey:@"axis"] valueForKey:@"os"];
    }else{
        self.axisRight.text = @"-";
        self.axisLeft.text = @"-";
    }
    if ([prescriptionDetails valueForKey:@"cylinder"]){
        self.cylinderRight.text = [[prescriptionDetails valueForKey:@"cylinder"] valueForKey:@"od"];
        self.cylinderLeft.text = [[prescriptionDetails valueForKey:@"cylinder"] valueForKey:@"os"];
    }else{
        self.cylinderRight.text = @"-";
        self.cylinderLeft.text = @"-";
    }
    
}
@end
